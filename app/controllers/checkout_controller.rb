# frozen_string_literal: true

class CheckoutController < ApplicationController
  include CheckoutHelper
  include ApplicationHelper
  before_action :authenticate_user!
  def create
    @session = Stripe::Checkout::Session.create(
      {
        customer: current_user.stripe_customer_id,
        payment_method_types: ['card'],
        line_items: @cart.collect { |item| to_stripe_item(item).attributes! },
        allow_promotion_codes: true,
        mode: 'payment',
        success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: cancel_url
      })
    redirect_to @session.url
  end

  def success
    if params[:session_id].present?
      session[:cart] = {}
      @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ['line_items'] })
      @session_with_expand.line_items.data.each do |line_item|
        product = Product.find_by(stripe_product_id: line_item.price.product)
      end
    else
      redirect_to cancel_url
    end
  end
end
