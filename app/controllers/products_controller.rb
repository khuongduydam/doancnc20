class ProductsController < ApplicationController
  def index
    @products = Product.search_filter(params[:search],params[:category],params[:minValue],params[:maxValue])
  end
  
  def show
    @product = Product.find(params[:id])
  end

  def all_pro
    @products = Product.order(created_at: :desc).search(params[:search]).paginate(:per_page => 12, :page => params[:page])
  end
end