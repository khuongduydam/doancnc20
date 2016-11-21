class ProductsController < ApplicationController
  def index
    @products = Product.all
  end
  def show
    @product = Product.find(params[:id])
  end

  def new_products
    @products = Product.first(10)
  end
end