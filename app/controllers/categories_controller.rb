class CategoriesController < ApplicationController
  def show
    @products = Product.where(category_id: params[:id])
    @category = Category.find_by(id: params[:id])
    @wishlists = WishList.first(3)
  end
  def index
    @categories = Category.all    
  end
end