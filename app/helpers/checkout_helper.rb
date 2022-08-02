# frozen_string_literal: true

module CheckoutHelper
  def to_stripe_item(item)
    Jbuilder.new do |product|
      product.price item.stripe_price_id
      product.quantity session[:cart][item.id.to_s]
    end
  end

  def create_checkout_seesion(cart)
    Stripe::Checkout::Session.create(
    {
      customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: cart.collect { |item| to_stripe_item(item).attributes! },
      allow_promotion_codes: true,
      mode: 'payment',
      success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url
    })
  end
end
