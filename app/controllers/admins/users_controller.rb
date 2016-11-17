class Admins::UsersController < AdminsController
  before_action :find_user, except: :index
  def index
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

  def destroy
    if @user.destroy
      redirect_to admins_path
    end
  end
  private

  def find_user
    @user = User.find(params[:id])
  end

  def params_user
    params.require(:user).permit(:username, :first_name,:last_name, 
                                 :email, :password,:password_confirmation,
                                 :address, :phone, :sex, :birth_day)
  end
end
