class V1::CommentsController < ApplicationController
  before_action :set_user, only: %i[create]
  before_action :set_comment, only: %i[destroy]

  def index
    comments = Comment.where(post_id: params[:post_id]).order(created_at: :desc)
    render json: comments
  end

  def create
    @comment = @user.comments.create!(comment_params)
    @comment.save!
    @comment.notification_comment!(@comment.user_id, @comment.post_id)
    render json: @comment
  end

  def destroy
    @comment.destroy!
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

end
