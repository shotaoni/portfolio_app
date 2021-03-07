class V1::LikesController < ApplicationController
  before_action :set_user, only: %i[create]

  def index
    @like = if params[:userid] && params[:post_id]
              Like.find_by(user_id: params[:userid], post_id: params[:post_id])
           elsif params[:post_id]
              Like.where(post_id: params[:post_id])
           elsif params[:user_id]
              Like.where(user_id: params[:user_id])
           else
            []
           end
    render json: @like
  end

  def show
    @like = Like.all
    render json: @like
  end

  def create
    like = @current_user.likes.create!(like_params)
    like.create_notification_like!(current_user)
    render json: like
  end

  def destroy
    like = Like.find_by(user_id: params[:user_id], post_id: params[:post_id])
    like.destroy
    render json: like
  end

  private

  def set_user
    @current_user = User.find(params[:userid])
  end

  def like_params
    params.require(:like).permit(:post_id)
  end
end
