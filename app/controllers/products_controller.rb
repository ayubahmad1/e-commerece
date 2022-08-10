# frozen_string_literal: true

class ProductsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, except: %i[index show all_products]
  before_action :set_product, only: %i[show edit update destroy]
  # before_action :set_product, except: %i[new create index]
  before_action :authorize_product, only: %i[edit update destroy]

  after_action :verify_authorized, only: %i[edit update destroy]

  def index
    @products = current_user.products
  end

  def all_products
    @q = Product.ransack(params[:q])
    return @products = @q.result(distinct: true).all_products_except_mine(current_user) if user_signed_in?

    @products = @q.result(distinct: true)
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    if @product.destroy
      redirect_to user_products_path
    else
      flash[:alert] = 'There is some error in destroying Product'
    end
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def authorize_product
    authorize @product
  end

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, images: [])
  end
end
