class V1::RelationshipsController < ApplicationController
  before_action :set_user, only: %i[create destroy]

  def show
    @relationships = Relationship.all
    render json: @relationships
  end

  def index
    @Relationship = if params[:userid] && params[:followed_id]
                      Relationship.find_by(follower_id: params[:userid], followed_id: params[:followed_id])
                    elsif params[:userid]
                      Relationship.where(follower_id: params[:userid]).order(created_at: 'DESC')
                    elsif params[:followed_id]
                      Relationship.where(followed_id: params[:followed_id]).order(created_at: 'DESC')
                    else
                      []
                    end
    render json: @Relationship
  end

  def create
    @user = User.find(params[:followed_id])
    @current_user.follow(@user)
    @user.create_notification_follow!(current_user)
    render json: @user
  end

  def destroy
    @user = User.find(params[:unfollowed_id])
    @current_user.unfollow(@user)
    render json: @user
  end

  private

    def set_user
      if(!@current_user)
      @current_user = User.find(params[:userid])
      end
    end

end
