class AdminsController < ActionController::Base
  before_action :admin_only, :authenticate_user!
  layout 'admin_layout'

  def index
  end

  def admin_only
    unless current_user.admin? 
      flash[:error] = "You are not allow to access"
      sign_out current_user
    end
    rescue
      root_path
  end


  private :admin_only
end
