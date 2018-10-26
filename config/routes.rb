Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  ActiveAdmin.routes(self)
  resources :users, only: [:index, :show]
  resources :clients
end
