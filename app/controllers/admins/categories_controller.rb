class Admins::CategoriesController < AdminsController
  def index
    @categories = Category.all 
  end

  def new
    @category = Category.new                                                                                                                              
    # @category.pictures.build
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admins_categories_path
    else
      # flash[:error] = @category.errors.full_messages
      render 'new'
      puts @category.errors.full_messages
      # render new_admins_category_path
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