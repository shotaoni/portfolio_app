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
    resources :posts
    resources :relationships
    resources :likes
      post 'likes/likenone', to: 'likes#destroy'
    resources :comments
  end
end
