# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users
  resource :user, shallow: true do
    resources :products, shallow: true do
      resources :comments
    end
  end

  resource :cart, only: :show

  get "welcome/index", to: "welcome#index", as: "products"

  post "checkout/create", to: "checkout#create", as: "checkout"
  get "success", to: "checkout#success", as: "success"
  get "cancel", to: "checkout#cancel", as: "cancel"

  put 'products/update_quantity/:id', to: 'products#update_quantity', as: 'update_quantity'
  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  get '/401', to: 'welcome#page_unauthorized', as: :page_unauthorized
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
