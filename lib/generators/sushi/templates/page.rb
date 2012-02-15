class Page < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  before_save :downcase_name
  has_ancestry
  
  def title
    name.titleize
  end
  
  def search_result_title
    r = page_title.split(' | ')
    r[0]
  end
  
  def title
    name.titleize
  end
  
  def link
    short_nav.blank? ? title : short_nav
  end
  
  def nav_path
    name
  end
  
  scope :visible, where("visible = ?", true).order('id')
  scope :home, where("page_type = ?", 'home')
  scope :has_ancestors, where(:ancestry => nil)
  scope :show_in_nav, where("show_in_nav = ?", true)
  scope :sorted, order("order_by")
  
  def self.navigation
    has_ancestors.show_in_nav.sorted
  end
  
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ? OR content LIKE ? OR page_title LIKE ? OR meta_keywords LIKE ? OR meta_description LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end

  private
  
  def downcase_name
    self.name.downcase! unless self.name.blank?
  end
end
