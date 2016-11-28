class Admins::NewspapersController < AdminsController
  def index
    @newspapers = Newspaper.all
  end

  def new
    @newspaper = Newspaper.new
  end

  def create
    @newspaper = Newspaper.new(newspaper_params)
    if @newspaper.save
      redirect_to admins_newspapers_path
    else
      redirect_to root_path
    end
  end

  def edit
    @newspaper = Newspaper.find(params[:id])
  end

  def update
    @newspaper = Newspaper.find(params[:id])
    if @newspaper.update_attributes(newspaper_params)
      redirect_to admins_newspapers_path
    else
      redirect_to root_path
    end
  end

  def show
    @newspaper = Newspaper.find(params[:id])
  end

  def destroy
    Newspaper.find(params[:id]).destroy
    flash[:success] = "Newspaper deleted"
    redirect_to admins_newspapers_path
  end
  
  private
  def newspaper_params
    params.require(:newspaper).permit(:title, :content)
  end
end
