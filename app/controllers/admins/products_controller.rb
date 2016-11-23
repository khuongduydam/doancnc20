class Admins::ProductsController < AdminsController
  def index
     @products = Product.all
  end 
  
  def new
    @product = Product.new
    @categories = Category.all
    @picture = @product.pictures.build
  end
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admins_products_path
    else
      redirect_to root_path
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      redirect_to admins_products_path
    else
      redirect_to root_path
    end
  end
  def show
    
  end
  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Product deleted"
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :origin, :category_id, :description, :quantity ,pictures_attributes: [:id, :image, :_destroy])
  end
end