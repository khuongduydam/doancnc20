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
    @order_members = OrderMember.all.order(created_at: :desc).paginate(:per_page => 1, :page => params[:page])
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
