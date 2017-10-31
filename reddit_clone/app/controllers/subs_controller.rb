class SubsController < ApplicationController

  before_action :require_user_is_moderator, only: [:edit, :update]

  def require_user_is_moderator
    current_user.moderated_subs.ids.include?(params[:id])
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = current_user.moderated_subs.find(params[:id])
    if @sub
      if @sub.update_attributes(sub_params)
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] = @sub.errors.full_messages
        render :edit
      end
    else
      flash.now[:errors] = 'Permissions error: you are not the moderator.'
      render :edit
    end
  end

  def destroy
    @sub = current_user.moderated_subs.find(params[:id])
    @sub.destroy if @sub
    redirect_to subs_url
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
