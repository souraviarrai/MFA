# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :users
  resources :products
  resources :outlets
  resources :outlet_products
  resources :orders
  get '/pendings', to: 'outlets#pending'
  get '/outlets/pending/:id', to: 'outlets#pending_show'
  put '/outlets/pending/accept/:id', to: 'outlets#accept'
  delete '/outlets/pending/reject/:id', to: 'outlets#reject'
  post '/outlets/email_invite', to: 'outlets#inivte_outlet_admins'
  post '/signin', to: 'users#signin'
  post '/logout', to: 'users#logout'
end
