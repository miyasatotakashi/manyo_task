Rails.application.routes.draw do
  get 'sessions/new'
  root "tasks#index"
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :tasks do
    collection do
      post :confirm
      get 'search'
    end
  end
end