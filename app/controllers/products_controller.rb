class ProductsController < ApplicationController
  def index
    @product_news = Product.search(params[:search]).order(created_at: :desc).first(10)
  end
  
  def show
    @product = Product.find(params[:id])
  end
end