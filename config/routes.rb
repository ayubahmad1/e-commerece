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

  put 'products/update_quantity/:id', to: 'products#update_quantity', as: 'update_quantity'
  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
