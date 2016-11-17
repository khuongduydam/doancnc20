class UsersController < ApplicationController
  before_action :authenticate_user!, :find_user
   
  def show
  end

  def find_user
    @user = User.find(params[:id])
  end 
end
