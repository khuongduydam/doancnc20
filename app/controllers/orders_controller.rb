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
    @order.total_price = @cart.total_price.to_f
    unless @order.save
      flash.now[:error] = "Can not create order, please try again"
      render :new
    else
      @order.order_items.each do |item|
        product = Product.find_by(id: item.product.id)
         p product
        if product.price_discount.present?
          product.price_to_buy = product.price_discount
        else
          product.price_to_buy = product.price
        end
        unless product.save
          flash[:error] = "Price to buy failed to save"
        else
          p "**********************************"
          p product.price_to_buy
          p "**********************************"
          flash[:success] = "Price to buy save success"
        end
      end
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      if @order.pay_type == 'Direct'
        flash[:success] = "Thank you for your order"
        redirect_to root_path
      else
        redirect_to @cart.paypal_url(products_url)
      end
    end 
  end
  
  def edit
    
  end

  def update
    unless @order.update(order_update)
      flash[:error] = 'Order can not be updated'
      render :edit
    else
      if @order.status == "Complete"
        @order.save
        flash[:success] = "Order is completed, ready to delivery"
        redirect_to admins_orders_path
      else
        redirect_to admins_orders_path
      end
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
