module ApplicationHelper
  def nav_active_home
    if current_page?(root_url)
      "active"
    end
  end

  def nav_active_shop
    unless current_page?(root_url)
      "active"
    end
  end

end
