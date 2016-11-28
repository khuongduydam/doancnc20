class NewspapersController < ApplicationController
  def show
    @newspaper = Newspaper.find(params[:id])
    @wishlists = WishList.first(3)
    
  end

  def index
    @newspapers = Newspaper.all
    @wishlists = WishList.first(3)
    
  end
end