class Products::CommentsController < CommentsController
  before_action :set_commentable
  
  private
  
  def set_commentable
    @product = Product.find_by(id: params[:product_id])
  end
end