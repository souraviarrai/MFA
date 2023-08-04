# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :users
  resources :products
  resources :outlets
  resources :outlet_products
  resources :orders
  post "/signin", to: "users#signin"
  post "/logout", to: "users#logout"
end
