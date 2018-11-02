Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  ActiveAdmin.routes(self)
  resources :users, only: [:index, :show]
  resources :clients
  resources :projects do
    resources :payments
    resources :comments
  end
end
