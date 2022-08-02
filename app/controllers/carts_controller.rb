# frozen_string_literal: true

class CartsController < ApplicationController
  include CartsHelper
  def show
    @total_price = total
  end
end
