Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: "homes#top"
  get "homes/about" =>"homes#about"
  # root 'posts#index'

   
  resources :posts, only:[:new, :create, :index, :show, :destroy] do
  resource :favorites, only:[:create, :destroy]
  resources :post_comments, only:[:create, :destroy]
 end
 resources :users, only:[:index, :show, :edit, :update]do
 resource :relationships, only: [:create, :destroy]
 get "followings" => "relationships#followings", as: "followings"
 get "followers" => "relationships#followers", as: "followers"
 end
end

