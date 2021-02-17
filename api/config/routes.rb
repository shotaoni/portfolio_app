Rails.application.routes.draw do
  resources :posts
  namespace :v1 do
    resources :users do
      member do
        patch '/update_avatar', to: 'users#update_avatar'
      end
    end
    resources :posts
  end
end
