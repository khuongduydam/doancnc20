class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :find_order, only: [:show, :edit, :update, :destroy]

  def new
    if @cart.order_items.empty?
      redirect_to root_path
      return
    end
    @order = Order.new
  end
end
