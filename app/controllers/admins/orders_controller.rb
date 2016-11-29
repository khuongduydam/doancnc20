class Admins::OrdersController < AdminsController
  before_action :find_order, except: [:index, :new]
  def index
    @orders = Order.all.order(created_at: :desc).paginate(:per_page => 10, :page => params[:page])
  end

  def show
    order_item = OrderItem.find_by(order_id: @order.id)
    @product = order_item.product
  end

  def edit
  end

  def update
    if @order.update(update_params)
      flash[:success] = "Order Completed"
      redirect_to admins_orders_path
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to admins_path
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def update_params
    params.require(:order).permit(:status)
  end
end