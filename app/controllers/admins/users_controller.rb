class Admins::UsersController < AdminsController
  before_action :find_user, except: :index
  def index
    @users = User.all.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(params_user)
      flash[:notice] = "Update success"
      redirect_to @user
    else
      flash.now[:error] = "Something wrong"
      render 'edit'
    end
  end

  private

  def find_user
    begin
      @user = User.try(:find,params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to admins_path, :alert => 'User not found'
    end
  end

  def params_user
    params.require(:user).permit(:username, :first_name,:last_name, 
                                 :email, :password,:password_confirmation,
                                 :address, :phone, :sex, :birth_day)
  end
end
