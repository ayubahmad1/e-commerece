# frozen_string_literal: true

module Api
  class ProductsController < ApplicationController
    def index
      products = Product.all
      render json: {status: 'SUCCESS', message: 'Loaded Products', data: products }, status: :ok
    end

    def show
      product = Product.find(params[:id])
      render json: {status: 'SUCCESS', message: 'Loaded Product', data: product }, status: :ok
    end

  end
end
