class Admins::CategoriesController < AdminsController
  def index
    @categories = Category.all.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
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
        flash[:success] = 'Add category success'
        redirect_to admins_categories_path
      else
        flash.now[:error] = 'Can not add category'
        render 'new'
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
      flash[:success] = 'Add category success'
      redirect_to admins_categories_path
    else
      flash.now[:error] = 'Can not update category'
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
