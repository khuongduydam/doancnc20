module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Fruit shop"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def wishlists
    unless current_user.nil?
      @wishlists = WishList.where(user_id: current_user.id).first(3)
    end
  end
end
