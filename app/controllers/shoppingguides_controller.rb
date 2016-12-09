class ShoppingguidesController < ApplicationController
 def index
    @wishlists = WishList.first(3)
 end
end