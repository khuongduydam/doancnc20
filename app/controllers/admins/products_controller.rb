class Admins::ProductsController < AdminsController
  def index
    @products = Product.all.order(created_at: :desc).search(params[:search]).paginate(:per_page => 10, :page => params[:page])
    respond_to do |format|
      format.html
      format.json{render json: {data: @products}}
    end
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
      flash[:error] = "Please choose image!"
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    if params[:product][:pictures_attributes].blank? && params[:product][:image].blank?
      flash[:error] = "Please choice image!"
      render 'edit'
    else
      if @product.update_attributes(product_params)
        if params[:product][:image].present?
          params[:product][:image].each do |img|
            @product.pictures << Picture.create(image: img)  
          end
        end
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
    redirect_to admins_products_path
  end

  private
  def product_params
    quan = params[:product][:quantity]
    quanToI = quan.to_i
    addQuan = params[:product][:addQuantity]
    addQuanToI = addQuan.to_i
    quanToI += addQuanToI
    params[:product][:quantity] = quanToI
    params.require(:product).permit(:name, :price, :origin, :category_id, :description, :quantity ,:price_discount,pictures_attributes: [:id, :image, :_destroy])
  end
end