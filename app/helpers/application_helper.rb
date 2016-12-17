module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Fruit shop"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def categories_list_head
    categories = Category.all
  end
  
  def wishlists
    unless current_user.nil?
      @wishlists = WishList.where(user_id: current_user.id).first(3)
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def hotProduct
    OrderItem.all().group("product_id").sum('quantity').sort_by {|_key, value| value}.reverse.to_a.first(5)
  end

  def findProduct(p_ID)
    Product.find(p_ID)
  end
end
