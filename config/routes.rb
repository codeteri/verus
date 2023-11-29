Rails.application.routes.draw do
  root to: "articles#index"
  devise_for :users

  resources :articles do
    resources :bookmarks, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :votes, only: [:create, :destroy]
  end

  resources :users, only: [:show]
end
