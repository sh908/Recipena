Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/search', to: 'search#search'
  resources :posts, only: %i[new create index show destroy] do
    resource :favorites, only: %i[create destroy]
    resources :post_comments, only: %i[create destroy]
  end
  patch '/uers/hide' => 'users#hide', as: 'users_hide'
  get '/users/withdraw' => 'users#withdraw', as: 'users_withdraw'
  resources :users, only: %i[index show edit update destroy] do
    resource :relationships, only: %i[create destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
end
