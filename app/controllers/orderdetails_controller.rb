class OrderdetailsController < ApplicationController
  before_action :find_order, only: [:update, :destroy]
  def create
    @order = current_order
    @order_detail = @order.order_details.new(order_detail_params)
    @order.save
    session[:order_id] = @order.id
  end

  def update
    @order_detail.update_attributes(order_detail_params)
    @order_details = @order.order_details
  end

  def destroy
    @order_detail.destroy
    @order_details = @order.order_details
  end

  private
  def find_order
    @order = current_order
    @order_detail = @order.order_details.find(params[:id]) if params[:id].present?
  end

  def order_detail_params
    params.require(:order_detail).permit(:product_id, :quantity)
  end
end

