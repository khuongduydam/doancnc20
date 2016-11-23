class ProductsController < ApplicationController
  def index
    @product_news = Product.first(10)
    @wishlists = WishList.first(3)
  end

  def show
    @product = Product.try(:find,params[:id])
  end
end
