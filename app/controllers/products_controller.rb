class ProductsController < ApplicationController
  def index
    @product_news = Product.first(10)
    @wishlists = WishList.first(3)
    if current_user != nil
      @user = User.find(current_user.id)
    end
  end

  def show
    @wishlists = WishList.first(3)  
    @product = Product.try(:find,params[:id])
  end
end