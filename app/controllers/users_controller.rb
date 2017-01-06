class UsersController < ActionController::Base
  before_action :show, :authenticate_user!
  layout 'user_layout'
  def show
    @user  = User.find(params[:id])
  end
end
