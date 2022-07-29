class WelcomeController < ApplicationController
  def index
    @renderer = 'welcomeIndex'
    @products = Product.all
  end
end
