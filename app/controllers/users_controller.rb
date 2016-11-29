class UsersController < ActionController::Base
  before_action :show, :authenticate_user!
  layout 'user_layout'
  def show
    begin
      @user  = User.try(:find,params[:id]) if params[:id]
      if @user.admin?
        redirect_to root_path, :alert => 'User not found!.'
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, :alert => 'User not found!.'
    end
  end
end
