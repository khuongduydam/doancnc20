class ProductsController < ApplicationController
  def index
     
  end 
  def new
    @product = Product.new
    @categories = Category.all
    @picture = @product.pictures.build
  end
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  def edit
    
  end
  def update
    
  end
  def show
    
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :origin, :category_id, :description, :quantity ,pictures_attributes: [:id, :image, :_destroy])
  end
end