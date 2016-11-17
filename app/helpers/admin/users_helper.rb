module Admin::UsersHelper
  def user_error_messages!
    if @user.errors.full_messages.any?
      flash.now[:error] = @user.errors.full_messages.join('-')
    end
    return ''
  end
end
