class OrderItemsController < ApplicationController
  before_action :find_order_item, only: [:show, :edit, :destroy]

  def index
    @order_items = OrderItem.all
    order_item = OrderItem.find_by(id: params[:id])
    unless order_item.update(quantity: params[:quantity])
      flash.now[:error] = 'Update quantity failed'
    end
    product = order_item.product
    product.quantity -= params[:quantity].to_i - 1
    unless product.save
      flash.now[:error] = 'Update quantity failed'
    end
  end

  def new
    @order_item = OrderItem.new
  end

  def create
    product = Product.find(params[:product_id])
    @order_item = @cart.add_product(product.id)
    respond_to do |format|
      if @order_item.save
        product.quantity -= @order_item.quantity
        unless product.save
          flash.now[:error] = "Add product failed"
        end
        format.html {redirect_to root_path}
        format.js
      else
        flash.now[:error] = "Add product failed"
        format.html {render 'new'}
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
    unless @order_item.update(order_item_params)
      flash.now[:error] = 'Update quantity failed'
    else
      if @order_item.save
        product = Product.find_by(id: @order_item.product_id)
        product.quantity -= @order_item.quantity - 1
        unless product.save
          flash.now[:error] = 'Update quantity failed'
        end
        @order_items = @cart.order_items
      else
        flash.now[:error] = 'Update quantity failed'
      end
    end
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @order_item = @cart.order_items.find(params[:id])
    respond_to do |format|
      if @order_item.destroy
        product = Product.find_by(id: @order_item.product_id)
        product.quantity += @order_item.quantity
        unless product.save
          flash.now[:error] = 'Can not destroy this item'
        end
        @order_items = @cart.order_items
        format.html {redirect_to cart_path(session[:cart_id])}
        format.js 
      else
        flash.now[:error] = 'Can not destroy this item'
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
