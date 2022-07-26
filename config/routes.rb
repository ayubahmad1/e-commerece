# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users

  resource :user, shallow: true do
    resources :products, shallow: true do
      resources :comments
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
