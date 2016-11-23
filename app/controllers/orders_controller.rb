class OrdersController < ApplicationController
  def ordertemplate
    @order = current_user.order.new
  end

  def create
    @order = current_user.order.new(order_params)
    if @order.save
      redirect_to @order
  end
end