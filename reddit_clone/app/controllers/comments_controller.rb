class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      redirect_to post_url(@comment.post_id)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if @comment
    redirect_to post_url(@comment.post)
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
