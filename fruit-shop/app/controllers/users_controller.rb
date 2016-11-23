class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    puts current_user.email
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user= User.find(params[:id])
    if @user.update_attributes(user_params)
      bypass_sign_in(@user)
      redirect_to root_url
    else
      root_url
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :sex, :address, :phone, :birth_day)
    end
end