# frozen_string_literal: true

class CheckoutController < ApplicationController
  include CheckoutHelper
  include ApplicationHelper
  before_action :authenticate_user!
  def create
    @session = create_checkout_seesion(@cart)
    redirect_to @session.url
  end

  def success
    if params[:session_id].present?

      @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ['line_items'] })
      @session_with_expand.line_items.data.each do |line_item|
        Product.find_by(stripe_product_id: line_item.price.product)
      end
      session[:cart] = {}
    else
      redirect_to cancel_url
    end
  end
end
