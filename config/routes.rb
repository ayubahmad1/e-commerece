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

  post "checkout/create", to: "checkout#create", as: "checkout"
  get "success", to: "checkout#success", as: "success"
  get "cancel", to: "checkout#cancel", as: "cancel"

  put 'carts/update_quantity/:id', to: 'carts#update_quantity', as: 'update_quantity'
  post 'carts/add_to_cart/:id', to: 'carts#add_to_cart', as: 'add_to_cart'
  delete 'carts/remove_from_cart/:id', to: 'carts#remove_from_cart', as: 'remove_from_cart'
end
