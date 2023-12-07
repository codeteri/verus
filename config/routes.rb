Rails.application.routes.draw do
  root to: "articles#index"
  devise_for :users

  resources :articles, except: %i[edit update destroy] do
    collection do
      get 'search', to: 'articles#search'
    end
  
    resources :bookmarks, only: %i[create destroy]
    resources :comments, only: %i[create edit update destroy] do
      member do
        put "like", to: "comments#like"
        put "dislike", to: "comments#dislike"
      end
    end
    resources :votes, only: %i[create]
  end

  resources :users, only: [] do
    get 'view/:view', to: 'pages#dashboard', on: :member, as: :view
  end

  get 'dashboard', to: 'pages#dashboard'
end
