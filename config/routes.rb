Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'studios#top'

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      resource :relationships, only: [:create, :destroy]
      get :follows
      get :followers
      get :favorites
      get :reviews
      get :studios
    end
  end

  resources :studios do
    resource :favorites, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy] do
      resource :likes, only: [:create, :destroy]
    end
    collection do
      get :ranks
      get :searches
    end
  end
end
