class ProductsController < ApplicationController
  # before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  after_action :verify_authorized, only: %i[edit update destroy]
  # after_action :verify_policy_scoped, only: :index

  def index
    @products = current_user.products
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      redirect_to product_url(@product), notice: "Product was successfully created."
    else
      render 'new'
    end
  end

  def update
    @product = current_user.products.find(params[:id])
    authorize @product
    if @product.update(product_params)
      redirect_to @product
    else
      render new
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to user_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price)
  end
end
