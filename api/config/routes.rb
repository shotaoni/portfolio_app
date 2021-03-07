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
    end
    resources :relationships
    resources :likes
      post 'likes/likenone', to: 'likes#destroy'
    resources :comments, only: [:create, :destroy]
    resources :notifications, only: :index
  end
end
