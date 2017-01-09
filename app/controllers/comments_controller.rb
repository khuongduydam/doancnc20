class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = @product.comments.new comment_params
    @comment.user = current_user
    redirect_to @product if @comment.save
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

