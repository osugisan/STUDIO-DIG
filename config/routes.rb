Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
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
      get :maps
    end
  end
end
