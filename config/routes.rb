Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks
  resources :tasks do
    collection do
      post :confirm
      get 'search'
    end
  end
end