class ShoppingguidesController < ApplicationController
 def shoppingguide
    @wishlists = WishList.first(3)
 end
end