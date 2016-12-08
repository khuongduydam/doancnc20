class OrderItemsController < ApplicationController
  before_action :find_order_item, only: [:show, :edit, :destroy]

  def index
    @order_items = OrderItem.all
  end

  def new
    @order_item = OrderItem.new
  end

  def create
    product = Product.find(params[:product_id])
    @order_item = @cart.add_product(product.id)
    respond_to do |format|
      if @order_item.save
        format.html {redirect_to root_path}
        format.js
        product.quantity -= @order_item.quantity
        product.save
      else
        format.html {render 'new'}
        flash.now[:error] = "Oops, something wrong. Try again!!!"
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @cart = Cart.find(session[:cart_id])
    @order_item = @cart.order_items.find(params[:id])
    @order_item.update(order_item_params)
    if @order_item.save
      product = Product.find_by(id: @order_item.product_id)
      product.quantity -= @order_item.quantity - 1
      product.save
      @order_items = @cart.order_items
    end
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @order_item = @cart.order_items.find(params[:id])
    respond_to do |format|
      if @order_item.destroy
        product = Product.find_by(id: @order_item.product_id)
        product.quantity += @order_item.quantity
        product.save
        @order_items = @cart.order_items
        format.html {redirect_to cart_path(session[:cart_id])}
        format.js
      end
    end
  end

  private

  def find_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end
