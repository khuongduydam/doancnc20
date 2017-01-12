class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
    @order_items = @cart.order_items
    if @order_items.size == 0
      redirect_to root_path
    end
    @cart.order_items.each{ |item| @product = Product.find(item.product_id) }
  end

  def destroy
    @cart.order_items.map do |item|
      product = Product.find_by(id: item.product_id)
      product.quantity += item.quantity
      unless product.save
        flash.now[:error] = 'Delele cart failed'
      end
    end  
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    flash[:success] = 'Cart was destroyed'
    redirect_to root_path
  end
  
  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_path, notice: 'Invalid cart'
  end
end
