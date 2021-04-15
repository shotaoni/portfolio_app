# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    def index
      if params[:uid]
        @current_user = User.find_by(uid: params[:uid])
        render json: @current_user
      elsif params[:name]
        @user = User.where('name LIKE ?', "%#{params[:name]}%").distinct
        render json: @user
      else
        @users = User.all
        render json: @users
      end
    end

    def show
      render json: @user
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      render json: @user if @user.update(user_params)
    end

    def destroy
      @user.destroy
    end

    def following
      @user  = User.find(params[:id])
      @users = @user.following
      render json: @users
    end

    def followers
      @user  = User.find(params[:id])
      @users = @user.followers
      render json: @users
    end

    def update_avatar
      @user = User.find(params[:id])
      @user.avatar.attach(params[:avatar])
      render json: @user
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :uid, :profile, :avatar)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
