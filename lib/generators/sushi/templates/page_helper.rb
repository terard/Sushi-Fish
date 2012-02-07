module PageHelper
  def title(page_title)
    content_for(:title) { page_title.to_s + " | Application Name" }
  end
  
  def page_name(name)
    content_for(:page_name) { name.to_s }
  end
  
  def meta_desc(desc)
    content_for(:meta_desc) { desc.to_s }
  end
  
  def meta_keywords(desc)
    content_for(:meta_keywords) { desc.to_s }
  end
  
  def sidebar(content)
    content_for(:sidebar) { content.to_s }
  end  
  
  def nav_link(page)
    # link_to page.titleize, page_path(page.downcase), :id => page
    if page.nav_path == ""
      link_to page.link, '#'
    else
      link_to page.link, link_path(page.root.name, page.nav_path)
    end
  end
  
end