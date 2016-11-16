class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :permitted_params, if: :devise_controller?
  def after_sign_in_path_for(resource)
    if current_user.role == "admin"
      admin_path
    else
      root_path
    end
  end
  def permitted_params
    sign_up = -> u {u.permit(:username, :first_name,:email, :last_name, 
                             :password,:password_confirmation,:address, 
                             :phone, :sex, :birth_day)}
    sign_in = -> u {u.permit(:username, :password)}
    account_update = -> u {u.permit(:username, :first_name,:last_name, 
                                    :email, :password,:password_confirmation,
                                    :address, :phone, :sex, :birth_day,:current_password)}
    devise_parameter_sanitizer.permit(:sign_up,&sign_up)
    devise_parameter_sanitizer.permit(:sign_in,&sign_in)
    devise_parameter_sanitizer.permit(:account_update,&account_update)
  end

  private :permitted_params
end
