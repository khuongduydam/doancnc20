class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = @product.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Add comment success'
      redirect_to @product 
    else
      flash.now[:error] = 'Can not add comments'
      redirect_to @product
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to :back
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end

