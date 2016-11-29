module ProductsHelper
  def user
    unless current_user.nil?
      User.find(current_user.id)
    end
  end
end