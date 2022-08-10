# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#all_products'

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
  devise_for :users
  resource :user, shallow: true do
    resources :products, shallow: true do
      get 'all_products', on: :collection
      resources :comments
    end
  end

  resources :carts, only: %i[show index] do
    member do
      put 'update_quantity', as: 'update_quantity'
      post 'add_to_cart', as: 'add_to'
      delete 'remove_from_cart', as: 'remove_from'
    end
  end

  resource :checkouts, only: [:create] do
    member do
      get 'success'
      get 'cancel'
    end
  end

end
