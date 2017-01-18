class OrderMembersController < ApplicationController
  before_action :find_order_member, only: :update
   
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
    gift_code = Giftcode.find_by(gift_code: params[:order_member][:gift_code])    
    unless gift_code.present?
      @order_member.total_price = @cart.total_price
    else
      case gift_code.gift_code.size 
        when 20
          @order_member.total_price = @cart.total_price(0.9)
        when 21
          @order_member.total_price = @cart.total_price(0.8)  
        when 22
          @order_member.total_price = @cart.total_price(0.7)
        when 23
          @order_member.total_price = @cart.total_price(0.6)
        when 24
          @order_member.total_price = @cart.total_price(0.5)
        when 22
          @order_member.total_price = @cart.total_price(0.4)        
        else
          @order_member.total_price = @cart.total_price
      end
      gift_code.destroy
    end
    unless @order_member.save   
      flash[:error] = "Your order is not complete"
      render :new
    else
      @order_member.order_items.each do |item|
        product = Product.find_by(id: item.product.id)
        if product.price_discount.present?
          product.price_to_buy = product.price_discount
        else
          product.price_to_buy = product.price
        end
        unless product.save
          flash[:error] = "Price to buy failed to save"
        else
          p "**********************************"
          p product.price_to_buy
          p "**********************************"
          flash[:success] = "Price to buy save success"
        end
      end
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      if (params[:order_member][:gift_code].present?) && gift_code.present?
        @order_member.note << "\nThis order used gift code"
        @order_member.save
      end
      if @order_member.pay_type == 'Direct'
        flash[:success] = "Thank you for your Order"
        redirect_to root_path
      else
        redirect_to @cart.paypal_url(products_url)    
      end
    end
  end

  def update
    unless @order_member.update(member_update)
      flash[:error] = "Order can not be updated"
      render :edit 
    else
      if @order_member.status == "Complete"
        @order_member.save!
        flash[:success] = "Order is completed, ready to delivery"
        redirect_to admins_order_members_path
      else 
        redirect_to admins_order_members_path
      end
    end
  end

  private

  def member_params
    params.require(:order_member).permit(:username,:fullname, :address, :phone, :email, :pay_type, :note, :gift_code, :user_id)
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

