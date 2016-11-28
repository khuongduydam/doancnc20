class Admins::ProductsController < AdminsController
  def index
     @products = Product.all.order(created_at: :desc).paginate(:per_page => 10, :page => params[:page])
  end 
  
  def new
    @product = Product.new
  end
  def create
    @product = Product.new(product_params)
    if params[:product][:pictures_attributes].present?
      if @product.save
        redirect_to admins_products_path
      else
        render 'new'
      end
    else
      flash[:error] = "Please choice image!"
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    if params[:product][:pictures_attributes].blank?
      flash[:error] = "Please choice image!"
      render 'edit'
    else
      # sss
      if @product.update_attributes(product_params)
        @product.pictures << Picture.create(image: params[:product][:image])
        # ssajd
        redirect_to admins_products_path
      else
        render 'edit'
      end
    end
  end
  def show
    @product = Product.find(params[:id])
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