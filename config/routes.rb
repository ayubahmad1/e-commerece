# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#all_users_products'
  devise_for :users
  resource :user, shallow: true do
    resources :products, shallow: true do
      resources :comments
    end
  end

  resource :cart, only: :show

  get "products/all_users_products", to: "products#all_users_products", as: "products"

  post "checkout/create", to: "checkout#create", as: "checkout"
  get "success", to: "checkout#success", as: "success"
  get "cancel", to: "checkout#cancel", as: "cancel"

  put 'products/update_quantity/:id', to: 'products#update_quantity', as: 'update_quantity'
  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
