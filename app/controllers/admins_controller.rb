  class AdminsController < ActionController::Base
  before_action :admin_only, :authenticate_user!
  layout 'admin_layout'

  def index
    @users = User.all.order(id: :asc)
    @products = Product.all.order(id: :asc)
    @newspapers = Newspaper.all
    @categories = Category.all
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
end
