class Admins::CategoriesController < AdminsController
  def index
    @categories = Category.all.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
    # render json: @categories
    respond_to do |format|
      format.html
      format.json{render json: {data: @categories}}
    end
  end

  def new
    @category = Category.new     
  end

  def create
    @category = Category.new(category_params)

    if params[:category][:pictures_attributes].present?
      if @category.save
        redirect_to admins_categories_path
      else
        # flash[:error] = @category.errors.full_messages
        render 'new'
        # puts @category.errors.full_messages
      end
    else
      flash[:error]="Please choose image!" 
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to admins_categories_path
    else
      render 'edit'
    end
  end
  
  def show
    @category = Category.find(params[:id])
  end

  def pro_of_cate
    @products = Product.where(category_id: params[:id])
    @category = Category.find_by(id: params[:id])
  end
  
  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category deleted"
    redirect_to admins_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name, pictures_attributes: [:id, :image, :_destroy])
  end
end
