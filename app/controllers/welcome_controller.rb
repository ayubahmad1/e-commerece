class WelcomeController < ApplicationController
  def index
    @renderer = 'welcomeIndex'
    # @products = Product.all
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def page_unauthorized
    render file: 'public/401.html', status: :unauthorized
  end
end
