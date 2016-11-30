class OrderItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :find_order_item, only: [:show, :edit, :update, :destroy]

  def index
    @order_items = OrderItem.all
  end

  def new
    @order_item = OrderItem.new
  end

  def create
    product = Product.find(params[:product_id])
    @order_item = @cart.add_product(product.id)
    if @order_item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:product_id)
  end
end
