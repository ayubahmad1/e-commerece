class CartsController < ApplicationController
  include CartsHelper
  def show
    @total_price = total
    @renderer = 'cartShow'
  end
end
