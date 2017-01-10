  class AdminsController < ActionController::Base
  before_action :admin_only, :authenticate_user!
  helper_method :sort_column, :sort_direction
  layout 'admin_layout'

  def index
    @users = User.all.order(id: :asc).search(params[:search]).paginate(:per_page => 1, :page => params[:page])
    @products = Product.all.order(sort_column+ " " +sort_direction).search(params[:search]).paginate(:per_page => 1, :page => params[:page])
    @newspapers = Newspaper.all.order(created_at: :desc).search(params[:search]).paginate(:per_page => 1, :page => params[:page])
    @categories = Category.all.search(params[:search]).paginate(:per_page => 1, :page => params[:page])
    @contacts = Contact.all.order(created_at: :desc).search(params[:search]).paginate(:per_page => 1, :page => params[:page])
    @orders = Order.all.order(created_at: :desc).paginate(:per_page => 1, :page => params[:page])
    if @orders.size != 0
      if (Order.last.created_at - Order.first.created_at)/1.month <= 1
        @total = Order.all.map{|item| item.total_price}.inject(0,&:+)
      end
    else
      flash.now[:error] = "There is no Order in this month"
      @total = 0
    end
    @order_members = OrderMember.all.order(created_at: :desc).paginate(:per_page => 1, :page => params[:page])
    if @order_members.size != 0
      if(Time.now - OrderMember.last.created_at)/1.month <= 1
        @total_member = OrderMember.all.map{|item| item.total_price}.inject(0,&:+)
      end
    else
      flash.now[:error] = "There is no Order Member is this month"
      @total_member = 0
    end
    @complete_orders = Order.where(status: 'Complete').size + OrderMember.where(status: 'Complete').size
    @uncomplete_orders = Order.where(status: 'Uncomplete').size + OrderMember.where(status: 'Uncomplete').size
  end

  def admin_only
    unless current_user.admin? 
      flash[:error] = "You are not allow to access"
      sign_out current_user
    end
    rescue
      root_path
  end
  def destroy
    @user = User.try(:find, params[:id])
    if @user.destroy
      redirect_to admins_path
    end
  end

  private :admin_only
  def sort_column
    Product.column_names.include?(params[:sort])?params[:sort] : "name" 
  end
  def sort_direction
    %w[asc desc].include?(params[:direction])?params[:direction] : "asc" 
  end
end
