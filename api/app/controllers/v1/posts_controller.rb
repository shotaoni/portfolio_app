class V1::PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
  
  def index
    if params[:user_like_posts] && params[:offset]
      user = User.find(params[:user_like_posts])
      @posts = user.liked_posts.limit(20).offset(params[:offset]).order(created_at: :desc)
    elsif params[:offset]
      @posts = Post.includes({ user: { avatar_attachment: :blob } }, :links).limit(20).offset(params[:offset]).order(created_at: :desc)
    elsif params[:user_like_posts]
      user = User.find(params[:user_like_posts])
      @posts = user.liked_posts.limit(20).order(created_at: :desc)
    elsif params[:my_post]
      @posts = Post.where(user_id: params[:my_post]).order(created_at: :desc)
    elsif params[:following_post]
      user = User.find(params[:following_post])
      following = user.following
      @posts = []
      following.each do |f|
        f.posts.each do |p|
          @posts.push(p)
        end
      end
      @posts.uniq!
      @posts.sort! do |a, b|
        b[:created_at] <=> a[:created_at]
      end
    elsif params[:title]
      @posts = Post.where('title LIKE ?', "%#{params[:title]}%").order(created_at: :desc).distinct. or Post.where('point LIKE ?', "%#{params[:title]}%").order(created_at: :desc).distinct
    else
      @posts = Post.includes({ user: { avatar_attachment: :blob } }, :links).limit(20).order(created_at: :desc)
    end
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    if (params[:image]).present?
      @post.image.attach(params[:image])
    end
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
    if (params[:image]).present?
      @post.image.attach(params[:image])
    end
    if @post.save!
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
      params.permit(:title, :user_id, :point)
    end
end
