Rails.application.routes.draw do
  root to: "articles#index"
  devise_for :users

  resources :articles, except: %i[edit update destroy] do
    resources :bookmarks, only: %i[create destroy]
    resources :comments, only: %i[create edit update destroy]
    resources :votes, only: %i[create]
  end

  resources :users, only: [] do
    get 'view/:view', to: 'pages#dashboard', on: :member, as: :view
  end

  get 'dashboard', to: 'pages#dashboard'
end
