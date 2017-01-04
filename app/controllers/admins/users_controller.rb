class Admins::UsersController < AdminsController
  before_action :find_user, except: :index
  def index
    @users = User.all.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
    respond_to do |format|
      format.html
      format.json {render json: {data: @users}}
    end
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
      render 'edit'
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def params_user
    params.require(:user).permit(:username, :first_name,:last_name, 
                                 :email,:address, :phone, :sex, :birth_day,
                                 :password,:password_confirmation)
  end
end
