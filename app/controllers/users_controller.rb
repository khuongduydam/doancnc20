class UsersController < ApplicationController
  before_action :authenticate_user!, :find_user
   
  def show
    @user  = User.try(:find,params[:id]) if params[:id]
  end

  def find_user
    begin
      @user = User.try(:find, params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to root_path, :alert => 'User not found!.'
    end  
  end
end
