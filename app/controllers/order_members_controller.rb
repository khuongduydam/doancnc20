class OrderMembersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :find_order_member, only: [:edit, :update]
  
  def new
    if @cart.order_items.empty?
      redirect_to root_path
      return
    end
    @order_member = OrderMember.new
  end

  def create
    @order_member = OrderMember.new(member_params)
    @order_member.add_order_items_from_cart(@cart)
    @order_member.total_price = @cart.total_price
    if @order_member.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      flash[:success] = "Thank you for your OrderMember"
      redirect_to root_path
    else
      flash.now[:error] = "Sorry, something wrong here. Try again!!!"
      p @order_member.errors.messages
      render :new
    end
  end
  def edit
    
  end

  def update
    @order_member.update(member_update)
    if @order_member.save
      flash[:success] = "Order is completed, ready to delivery"
      redirect_to admins_order_members_path
    else
      render :edit
    end
  end

  private

  def member_params
    params.require(:order_member).permit(:username,:fullname, :address, :phone, :email, :pay_type, :note, :pay_type)
  end

  def find_order_member
    begin
      @order_member = OrderMember.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "OrderMember not found"
      redirect_to root_path
    end  
  end

  def member_update
    params.require(:order_member).permit(:status)
  end
end

