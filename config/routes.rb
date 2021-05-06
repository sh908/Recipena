Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "homes/about" =>"homes#about"
   
  resources:posts, only:[:new, :create, :index, :show, :destroy] 
end
