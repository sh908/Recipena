Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "homes/about" =>"homes#about"
  root 'posts#index'

   
  resources :posts, only:[:new, :create, :index, :show, :destroy] do
  resources :favorites, only:[:create, :destroy]
  resources :post_comments, only:[:create, :destroy]
 end
end

