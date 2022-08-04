# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#all_products'
  devise_for :users
  resource :user, shallow: true do
    resources :products, shallow: true do
      get "all_products",on: :collection
      resources :comments
    end
  end

  resource :cart, only: :show



  # resources :checkout, only: [:create] do
  #   get 'success', as: "success"
  #   get 'cancel', as: "cancel"
  # end
  post "checkout/create", to: "checkout#create", as: "checkout"
  get "success", to: "checkout#success", as: "success"
  get "cancel", to: "checkout#cancel", as: "cancel"

  # get "products/all_users_products", to: "products#all_users_products", on: :collection


  # put 'products/update_quantity/:id', to: 'products#update_quantity', as: 'update_quantity'
  # post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  # delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  put 'carts/update_quantity/:id', to: 'carts#update_quantity', as: 'update_quantity'
  post 'carts/add_to_cart/:id', to: 'carts#add_to_cart', as: 'add_to_cart'
  delete 'carts/remove_from_cart/:id', to: 'carts#remove_from_cart', as: 'remove_from_cart'
end
