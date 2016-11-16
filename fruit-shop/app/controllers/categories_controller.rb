class CategoriesController < ApplicationController
  def index
    @categories = Category.all 
  end

  def new
    @category = Category.new
    @category.pictures.build
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      puts "1"
      redirect_to root_path
    else
      flash[:error] = @category.errors.full_messages
      puts @category.errors.full_messages
      redirect_to root_path

    end
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to categories_path
    else
      redirect_to categories_path
    end
  end
  
  def show
    
  end
  
  def destroy
    
  end

  private
  def category_params
    params.require(:category).permit(:name, pictures_attributes: [:id, :image, :_destroy])
  end
end