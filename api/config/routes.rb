# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  namespace :v1 do
    resources :users do
      member do
        get :following, :followers
        patch '/update_avatar', to: 'users#update_avatar'
        post '/unfollow', to: 'relationships#destroy'
      end
    end
    resources :posts do
      resources :comments, only: [:index]
      collection do
        get '/ranking', to: 'posts#ranking'
      end
    end
    resources :comments, only: [:index]
    resources :relationships
    resources :likes
    post 'likes/likenone', to: 'likes#destroy'
    resources :comments, only: %i[create destroy]
    resources :tasks, only: :index
    resources :notifications, only: %i[index show] do
      get :unchecked, on: :collection
      get :checked, on: :collection
    end
  end
end
