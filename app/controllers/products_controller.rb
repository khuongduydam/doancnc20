class ProductsController < ApplicationController
  def index
    @product_news = Product.first(10)
  end
  
  def show
    @product = Product.find(params[:id])
  end
end
