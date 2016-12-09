class OrdersController < ApplicationController
  before_action :find_order, only: [:edit, :update]
  
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
    @order.total_price = @cart.total_price
    if @order.pay_type == 'Direct' && @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      flash[:success] = "Thank you for your order"
      redirect_to root_path
    elsif @order.pay_type == 'Paypal' && @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to @cart.paypal_url(products_url)
    else
      flash.now[:error] = "Sorry, something wrong here. Try again!!!"
      render :new
    end
  end
  
  def edit
    
  end

  def update
    @order.update(order_update)
    if @order.status == "Complete" && @order.save
      flash[:success] = "Order is completed, ready to delivery"
      redirect_to admins_orders_path
    elsif @order.status == "Uncomplete" && @order.save
      redirect_to admins_orders_path
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :phone, :email, :pay_type, :note)
  end

  def find_order
    begin
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Order not found"
      redirect_to root_path
    end  
  end

  def order_update
    params.require(:order).permit(:status)
  end
end
