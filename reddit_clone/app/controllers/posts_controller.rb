class PostsController < ApplicationController

  before_action :require_user_is_author, only: [:edit, :update]

  before_action :require_logged_in

  def require_user_is_author
    current_user.posts.ids.include?(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @sub = Sub.find(params[:sub_id])
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    byebug
    if @post.save
      redirect_to subs_url
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_sub_post_url(params[:primary_sub_id])
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
        redirect_to subs_url
      else
        flash.now[:errors] = @post.errors.full_messages
        render :new
      end
    else
      flash.now[:errors] = 'Permissions Error: you are not the original author.'
      redirect_to sub_id(@post.subs.first)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy if @post
    redirect_to sub_url(@post.subs.last)
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
