class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
    @wishlists = WishList.first(3)
    @user = User.find_by(id: current_user.id) unless current_user.nil?
    @product_news = Product.search(params[:search]).order(created_at: :desc).first(10)
  end
  
  def show
    @product = Product.find(params[:id])
  end
end
