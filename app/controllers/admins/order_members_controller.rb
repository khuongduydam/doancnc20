class Admins::OrderMembersController < AdminsController
  before_action :find_order_member, except: :index
  def index
    @order_members = OrderMember.all.order(created_at: :desc).paginate(:per_page => 10, :page => params[:page])
  end

  def show
    order_item = OrderItem.find_by(order_member_id: @order_member.id)
    @product = order_item.product
  end

  def edit
  end

  def update
    @order_member.update(order_params)
    if @order_member.save
      flash[:success] = "Order Complete, ready to delivery product!!!"
      redirect_to admins_order_members_path
    else
      render 'edit'
    end
  end

  def destroy
    @order_member.destroy
    redirect_to admins_path
  end

  private

  def find_order_member
    @order_member = OrderMember.find(params[:id])
  end

  def order_params
    params.require(:order_member).permit(:status)
  end
end