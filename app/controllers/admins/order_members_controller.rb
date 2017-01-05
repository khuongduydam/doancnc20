class Admins::OrderMembersController < AdminsController
  before_action :find_member, only: [:show, :destroy, :edit]
  def index
    @order_members = OrderMember.all.order(created_at: :desc).search(params[:search]).paginate(:per_page => 5, :page => params[:page])
    # render json: @order_members
    respond_to do |format|
      format.html
      format.json{render json: {data: @order_members}}
    end
  end
  def show
  end

  def edit
  end

  def destroy
    @order_member.destroy
    redirect_to admins_order_members_path
  end

  private

  def find_member
    if params[:id].present?
      @order_member = OrderMember.find(params[:id])
    else
      flash.now[:error] = "Order is not valid"
    end
  end
end
