class MyDevise::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, :only => [:create]


 protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :sex, :birth_day, :address, :phone])
  end

  # def account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :sex, :birth_day, :address, :phone])
  # end

  def sign_up(resource_name, resource)
    # new_user_session_path
    root_path
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end
end