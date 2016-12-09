class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :permitted_params, if: :devise_controller?
  layout :layout_devise
  
  def after_sign_in_path_for(resource)
    if current_user.admin?
      admins_path
    else
      root_path
    end
  end

  private

  def permitted_params
    sign_up = -> u {u.permit(:username, :first_name,:email, :last_name, 
     :password,:password_confirmation,:address, 
     :phone, :sex, :birth_day)}
    update = -> u {u.permit(:username, :first_name,:email, :last_name, 
     :password,:password_confirmation,:address, 
     :phone, :sex, :birth_day, :current_password)}
    devise_parameter_sanitizer.permit(:sign_up,&sign_up)
    devise_parameter_sanitizer.permit(:account_update,&update)
  end

  def layout_devise
    devise_controller? ? 'user_layout' : 'application'
  end

end
