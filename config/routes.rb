# frozen_string_literal: true

require 'api_constraints'

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  ActiveAdmin.routes(self)

  namespace :api, defaults: { format: :json } do
    namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: %i[show]
      resources :sessions, only: %i[create destroy]
      resources :projects, only: %i[show index]
    end

    get '*path', action: 'not_found'
    post '*path', action: 'not_found'
  end

  concern :commentable do
    resources :comments
  end
  resources :users, only: %i[index show]
  resources :clients
  resources :projects, concerns: :commentable do
    resources :payments
    resources :time_logs
  end
end
