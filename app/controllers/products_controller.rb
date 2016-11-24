class ProductsController < ApplicationController
  def index
    @product_news = Product.first(10)
    @wishlists = WishList.first(3)
    @user = User.find_by(id: current_user.id) unless current_user.nil?
  end

  def show
    @wishlists = WishList.first(3)  
    @product = Product.try(:find,params[:id])
  end
end
