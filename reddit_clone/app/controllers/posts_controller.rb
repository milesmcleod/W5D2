class PostsController < ApplicationController

  before_action :require_user_is_author, only: [:edit, :update]

  def require_user_is_author
    current_user.posts.ids.include?(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(post_params)
      if @post.save
        redirect_to sub_url(@post.sub)
      else
        flash.now[:errors] = @post.errors.full_messages
        render :new
      end
    else
      flash.now[:errors] = 'Permissions Error: you are not the original author.'
      redirect_to post_url(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy if @post
    redirect_to sub_url(@post.sub)
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
