class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_cart, only: [:new, :create]
  def index
    @orders = Order.all
  end

  def show
  end

  def new
    if @cart.order_items.empty?
      flash[:error] = "Your cart is empty"
      redirect_to root_path
      return
    end 
    @order = Order.new
  end
  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.add_order_items_from_cart(@cart)
    @order.total_price = @cart.total_price
    respond_to do |format|
      if @order.save
        Cart.last.delete
        session[:cart_id] = nil
        format.html { redirect_to root_path, notice: 'Thank you for your order' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :address, :phone, :email, :pay_type)
  end
end
