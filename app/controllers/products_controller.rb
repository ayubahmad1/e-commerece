class ProductsController < ApplicationController
  # before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show add_to_cart remove_from_cart]

  after_action :verify_authorized, only: %i[edit update destroy]
  # after_action :verify_policy_scoped, only: :index

  def index
    @products = current_user.products
    @caller_view = 'productIndex'
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
    authorize @product
    @product.destroy

    redirect_to user_products_path
  end

  def add_to_cart
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    flash[notice] = quantity
    # p quantity
    # p "somethinfdf"
    session[:cart][id] = quantity
    # unless session[:cart].include?(id)
    redirect_to root_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, images:[])
  end
end
