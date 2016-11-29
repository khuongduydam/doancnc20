class Admins::OrdersController < AdminsController
  def index
    @orders = Order.all.order(created_at: :desc).paginate(:per_page => 10, :page => params[:page])
  end

  def show
    @order = Order.find(params[:id])
    order_item = OrderItem.find_by(order_id: @order.id)
    @product = order_item.product
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to admins_path
  end
end