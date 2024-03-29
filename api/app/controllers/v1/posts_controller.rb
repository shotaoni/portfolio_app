# frozen_string_literal: true

module V1
  class PostsController < ApplicationController
    before_action :set_post, only: %i[show update destroy]

    def index
      if params[:user_like_posts] && params[:offset]
        user = User.find(params[:user_like_posts])
        @posts = user.liked_posts.limit(20).offset(params[:offset]).order(created_at: :desc)
      elsif params[:offset]
        @posts = Post.includes({ user: { avatar_attachment: :blob } },
                               :links).limit(20).offset(params[:offset]).order(created_at: :desc)
      elsif params[:user_like_posts]
        user = User.find(params[:user_like_posts])
        @posts = user.liked_posts.limit(20).order(created_at: :desc)
      elsif params[:my_post] && params[:offset]
        @posts = Post.where(user_id: params[:my_post]).limit(20).offset(params[:offset]).order(created_at: :desc)
      elsif params[:my_post]
        @posts = Post.where(user_id: params[:my_post]).limit(20).order(created_at: :desc)
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
        @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(20)
      elsif params[:title]
        @posts = Post.where('title LIKE ?',
                            "%#{params[:title]}%").order(created_at: :desc).distinct.or Post.where('point LIKE ?',
                                                                                                   "%#{params[:title]}%").order(created_at: :desc).distinct
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
      @post.image.attach(params[:image]) if params[:image].present?
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
      @post.image.attach(params[:image]) if params[:image].present?
      if @post.save!
        links = UpdateLink.new(@post).update_links(params[:links])
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def ranking
      if params[:offset]
        @posts = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id)).take(20)
        @posts = Kaminari.paginate_array(@posts).page(params[:offset]).per(20)
      elsif params[:comment]
        @posts = Post.find(Comment.group(:post_id).order('count(post_id) desc').limit(20).pluck(:post_id))
      else
        @posts = Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id)).take(20)
      end
      render json: @posts
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
end
