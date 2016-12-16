class Admins::OrderMembersController < AdminsController
  before_action :find_member, only: [:show, :destroy, :edit]

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
      flash.now[:error] = "Order is noit valid"
    end
  end
end
