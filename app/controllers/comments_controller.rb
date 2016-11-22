class CommentsController < ApplicationController
  before_action :find_commentable
  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    if @comment.save
      flash[:notice] = "Comment success posted"
      redirect_to :back
    else
      flash.now[:error] = "Something Wrong"
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_commentable
    @commentable = Comment.try(:find, params[:comment_id]) if params[:comment_id]
    @commentable = User.try(:find, params[:user_id]) if params[:user_id]
  end
end
