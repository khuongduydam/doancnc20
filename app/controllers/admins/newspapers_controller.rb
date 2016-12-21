class Admins::NewspapersController < AdminsController
  def index
    @newspapers = Newspaper.order(created_at: :desc).all.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
    # render json: @newspapers
    respond_to do |format|
      format.html
      format.json {render json: {data: @newspapers}}
    end
  end

  def new
    @newspaper = Newspaper.new
  end

  def create
    @newspaper = Newspaper.new(newspaper_params)
    if @newspaper.save
      redirect_to admins_newspapers_path
    else
      p "*"*50
      p @newspaper.errors.messages[:content]
      p "*"*50
      render 'new'
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
      render 'edit'
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
    params.require(:newspaper).permit(:title, :content, pictures_attributes: [:id, :image, :_destroy])
  end
end
