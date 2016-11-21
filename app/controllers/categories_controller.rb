class CategoriesController < ApplicationController
  def show
    @products = Product.where(category_id: params[:id])
    @category = Category.find_by(id: params[:id])
  end
  def index
    @categories = Category.all    
  end
end