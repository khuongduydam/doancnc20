class CategoriesController < ApplicationController
  def show
    @products = Product.where(category_id: params[:id]).search(params[:search]).paginate(:per_page => 10, :page => params[:page])
    @category = Category.find_by(id: params[:id])
  end
end