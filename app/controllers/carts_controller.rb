# frozen_string_literal: true

class CartsController < ApplicationController
  include CartsHelper
  def index
    @total_price = total(@cart)
  end

  def show
    @total_price = total(@cart)
  end

  def add_to_cart
    session[:cart][params[:id].to_i] = 1
    redirect_to request.referer
  end

  def update_quantity
    return if params[:quantity].nil?

    session[:cart][params[:id].to_i] = params[:quantity]
    redirect_to request.referer
  end

  def remove_from_cart
    return if params[:id].nil?

    session[:cart].delete(params[:id])
    redirect_to request.referer
  end
end
