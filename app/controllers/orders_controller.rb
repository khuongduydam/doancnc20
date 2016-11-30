class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :find_order, only: [:show, :edit, :update, :destroy]

  def index
    
  end

  def show

  end
  
  def new
    if @cart.order_items.empty?
      redirect_to root_path
      return
    end
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.add_order_items_from_cart(@cart)
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      flash[:success] = "Thank you for your order"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :phone, :email, :pay_type)
  end

  def find_order
    begin
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Order not found"
      redirect_to root_path
    end  
  end
end
