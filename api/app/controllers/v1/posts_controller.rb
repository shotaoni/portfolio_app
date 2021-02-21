class V1::PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
  
  def index
    if params[:offset]
      @posts = Post.includes({ user: { avatar_attachment: :blob } }, :links).limit(20).offset(params[:offset])
    else
      @posts = Post.includes({ user: { avatar_attachment: :blob } }, :links).limit(20)
    end
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)

    if @post.save!
      links = CreateLink.new(@post).create_links(params[:links])
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:user_id])
    @post.assign_attributes(post_params)
    if @post.save
      links = UpdateLink.new(@post).update_links(params[:links])
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @post.destroy
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :user_id, :point)
    end
end
