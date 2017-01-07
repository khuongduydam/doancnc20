class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
    @order_items = @cart.order_items
    if @order_items.size == 0
      redirect_to root_path
    end
    @gift_code = Giftcode.find_by(gift_code: params[:data])
    # if @gift_code.present?
    #   if @gift_code.gift_code.size == 50
    #     @cart.total_price *= 1.1
    #   end
    # end
    # p @cart.total_price
  end

  def destroy
    @cart.order_items.map do |item|
      product = Product.find_by(id: item.product_id)
      product.quantity += item.quantity
      product.save!
    end  
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
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
