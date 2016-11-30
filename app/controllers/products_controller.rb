class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @wishlists = WishList.first(3)
    @user = User.find_by(id: current_user.id) unless current_user.nil?
    @product_news = Product.order(created_at: :desc).first(8)
    @products = Product.order(created_at: :desc).search(params[:search]).paginate(:per_page => 8, :page => params[:page])
  end
  
  def show
    @product = Product.find(params[:id])
  end

  def all_pro
    @products = Product.order(created_at: :desc).search(params[:search]).paginate(:per_page => 12, :page => params[:page])
  end
end