Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    collection do
      post :confirm
      get 'search'
    end
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users
  end
end