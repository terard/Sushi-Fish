require 'rails/generators'
require 'rails/generators/migration'

class SushiGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  argument :app_name, :type => :string, :default => "website"
  
  def create_models
    generate :model, 'page name:string content:text page_title:string meta_keywords:text meta_description:text sidebar_html:text ancestry:string short_nav:string order_by:integer show_in_nav:boolean'    
    generate :model, 'stylesheet body:text'
    rake 'db:migrate'
    remove_file 'app/models/page.rb'
    copy_file 'page.rb', 'app/models/page.rb'
  end
  
  def indexes_and_defaults
    migration_template 'indexes_and_defaults.rb', 'db/migrate/indexes_and_defaults.rb'
    rake 'db:migrate'
  end
    
  def remove_files
    remove_file 'public/index.html' if File.exists?('public/index.html')
    remove_file 'app/views/layouts/application.html.erb' if File.exists?('app/views/layouts/application.html.erb')
    remove_file 'public/images/rails.png' if File.exists?('public/images/rails.png')
  end

  def add_routes
    route "root :to => 'page#show#index', :page => 'index'"
    route "match ':section(/:page)' => 'page#show#:page', :as => :link"
    route "resources :pages, :module => 'admin'"
    route "resources :messages, :module => 'admin'"
    # route "resource :stylesheet"
    # route "get 'stylesheets/open'"
  end

  def copy_files
    # copy_file 'admin_pages_controller.rb', 'app/controllers/admin/pages_controller.rb'
    remove_file 'app/controllers/application_controller.rb'
    copy_file 'application_controller.rb', 'app/controllers/application_controller.rb'
    # copy_file 'dashboard_controller.rb', 'app/controllers/dashboard_controller.rb'
    # copy_file 'stylesheets_controller.rb', 'app/controllers/stylesheets_controller.rb'
    copy_file 'page_controller.rb', 'app/controllers/page_controller.rb'
    copy_file 'page_helper.rb', 'app/helpers/page_helper.rb'
    copy_file 'index.html.haml', 'app/views/page/index.html.haml'
    copy_file 'page.html.haml', 'app/views/layouts/page.html.haml'
    template 'application.html.haml', 'app/views/layouts/application.html.haml'
    # copy_file 'style.sass', 'public/stylesheets/sass/style.sass'
    copy_file 'reset.css.scss', 'app/assets/stylesheets/reset.css.scss'
    # copy_file 'admin.sass', 'public/stylesheets/sass/admin.sass'
    copy_file 'layout.css.scss', 'app/assets/stylesheets/layout.css.scss'
    copy_file 'superfish.css.scss', 'app/assets/stylesheets/superfish.css.scss'    
    copy_file 'style.css.scss', 'app/assets/stylesheets/style.css.scss'
    copy_file 'show.html.haml', 'app/views/page/show.html.haml'
    copy_file '_header.html.haml', 'app/views/page/_header.html.haml'
    copy_file '_navigation.html.haml', 'app/views/page/_navigation.html.haml'
    copy_file '_sidebar.html.haml', 'app/views/page/_sidebar.html.haml'
    copy_file '_footer.html.haml', 'app/views/page/_footer.html.haml'  
    copy_file 'edit.html.erb', 'app/views/admin/pages/edit.html.erb'
    copy_file 'edit.html.haml', 'app/views/stylesheets/edit.html.haml'
    copy_file 'open.css.erb', 'app/views/stylesheets/open.css.erb'    
    copy_file 'pages_index.html.haml', 'app/views/admin/pages/index.html.haml'
    copy_file 'new.html.erb', 'app/views/admin/pages/new.html.erb'
    copy_file 'show.html.erb', 'app/views/admin/pages/show.html.erb'
    copy_file '_admin_nav.html.haml', 'app/views/layouts/_admin_nav.html.haml'
    copy_file '_form.html.erb', 'app/views/admin/pages/_form.html.erb'
  end
  
  def git_some
    run 'git init'
    run 'git add .'
    run "gc -m 'inital commit'"
  end
  
  def gems
    gem 'haml'
    gem 'ancestry'
    gem 'activeadmin'
    gem "meta_search", '>= 1.1.0.pre'

    run 'bundle'
  end
  
  def activeadmin
    generate "active_admin:install"
    generate "active_admin:resource Page Stylesheet"
    
    # app/admin/pages
    
    rake 'db:migrate'
  end
    
  def seed_data
    append_file 'db/seeds.rb', "Stylesheet.create! :body => '/* inject style here. */'\n"
    append_file 'db/seeds.rb', "Page.create! :name => 'index', :content => 'i am index. i have no data.'"
    rake 'db:seed'
  end

  def blast_off
    run 'touch tmp/restart.txt'
  end
  
  private 
  
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end
end
