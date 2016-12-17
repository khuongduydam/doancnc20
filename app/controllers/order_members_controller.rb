class OrderMembersController < ApplicationController
  before_action :find_order_member, only: :update
  
  # daisy
  def update_coin_total
    order_mem = OrderMember.find(params[:id]).total_price=params[:total_after]
    order_mem.save
    # kjdfsj
    user = User.find(current_user.id).coin = params[:coin]
    user.save
    

    # respond_to do |format|
    #   format.js
    # end

  end
  # end daisy
   
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
    # coin = params[:order_member][:coinUse]
    # coinToI = coin.to_f
    # coinToVND = coinToI * 22700
    # @order_member.total_price -= coinToVND
    # ssjdgjs
    if @order_member.pay_type == 'Direct' && @order_member.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      flash[:success] = "Thank you for your OrderMember"
      redirect_to root_path
    elsif @order_member.pay_type == 'Paypal' && @order_member.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to @cart.paypal_url(products_url)    
    else
      flash.now[:error] = "Sorry, something wrong here. Try again!!!"
      p @order_member.errors.messages
      render :new
    end
  end

  def update
    @order_member.update(member_update)
    user = User.find_by(username: @order_member.username)
    if @order_member.status == "Complete" && @order_member.save
      o_coin = @order_member.total_price*0.005 + user.coin
      user.update_attributes(coin: o_coin)
      flash[:success] = "Order is completed, ready to delivery"
      redirect_to admins_order_members_path
    elsif @order_member.status == "Uncomplete" && @order_member.save
      o_coin = user.coin - @order_member.total_price*0.005
      user.update_attributes(coin: o_coin)
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

