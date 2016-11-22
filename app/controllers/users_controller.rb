class UsersController < ApplicationController
  before_action :show
  def show
    begin
      @user  = User.try(:find,params[:id]) if params[:id]
      if @user.admin?
        redirect_to root_path, :alert => 'User not found!.'
      end
    rescue ActiveRecord::RecordNotFound => e
      redirect_to root_path, :alert => 'User not found!.'
    end
  end
end
