Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  ActiveAdmin.routes(self)

  concern :commentable do
    resources :comments
  end
  resources :users, only: [:index, :show]
  resources :clients
  resources :projects , concerns: :commentable do
    resources :payments
  end
end
