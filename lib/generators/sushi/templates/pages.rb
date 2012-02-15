ActiveAdmin.register Page do
  menu :priority => 3
  
  # filter :location
  filter :name
  
  form do |f|
    f.inputs "Details" do
      f.input :name
      # f.input :location
      f.input :short_nav
      f.input :parent_id, :as => :select, :collection => Page.where(:ancestry => nil)
      # f.input :is_root
    end
    f.inputs "Content" do
      f.input :content, :input_html => { :rows => 50 }
    end
    f.inputs "Search Engine" do
      # f.input :title_tag, :label => 'Title'
      f.input :meta_keywords, :input_html => { :rows => 3 }
      f.input :meta_description, :input_html => { :rows => 5 }
    end
    
    f.buttons
  end
  
  index do
    column :name
    # column :location
    column "Section", :sortable => :ancestry do |page|
      link_to page.root.name, edit_admin_page_path(page.root)
    end
    # column :order_by
    column :created_at
    column :updated_at
    
    default_actions
  end

  
end
