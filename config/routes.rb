# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root controller: :status, action: :index

  resources :event, only: :create
  namespace :event do
    resources :pair, only: :create
  end

  resources :invite, only: :index
  namespace :invite do
    resources :auth, only: :index
  end
end
