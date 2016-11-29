class OrderMembersController < ApplicationController
  include CurrentCart
  before_action :set_order_member, only: [:show, :destroy, :edit, :update]
  before_action :set_cart, only: [:new, :create]
  def index
    @order_members = OrderMember.all
  end

  def show
  end

  def new
    if @cart.order_items.empty?
      flash[:error] = "Your cart is empty"
      redirect_to root_path
      return
    end 
    @order_member = OrderMember.new
  end
  
  def edit
    
  end

  def update
    @order_member.update(order_members_update)
    if current_user.admin?
      if @order_member.save
        redirect_to admins_order_members_path
      else
        render 'edit'
      end
    end
  end

  def create
    @order_member = OrderMember.new(order_members_params)
    @order_member.add_order_items_from_cart(@cart)
    @order_member.total_price = @cart.total_price
    respond_to do |format|
      if @order_member.save
        Cart.last.delete
        session[:cart_id] = nil
        format.html { redirect_to root_path, notice: 'Thank you for your order' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @order_member.destroy
    respond_to do |format|
      format.html { redirect_to order_member_url, notice: 'Order was successfully destroyed.' }
    end
  end

  private
  def set_order_member
    @order_member = OrderMember.find(params[:id])
  end

  def order_members_params
    params.require(:order_member).permit(:name, :user_id, :note, :pay_type)
  end

  def order_members_update
    params.require(:order_member).permit(:status)
  end
end
