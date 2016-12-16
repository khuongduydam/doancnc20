class Admins::OrdersController < AdminsController
  before_action :find_order, only: [:show, :destroy, :edit]

  def show
  end

  def edit
  end

  def destroy
    @order.destroy
    redirect_to admins_orders_path
  end

  private

  def find_order
    unless params[:id].present?
      flash.now[:error] = "Order is not valid???"
      redirect_to admins_orders_path
    else
      @order = Order.find_by(id: params[:id])
    end
  end

end
