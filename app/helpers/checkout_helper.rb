# frozen_string_literal: true

module CheckoutHelper
  def to_stripe_item(item)
    Jbuilder.new do |product|
      product.price item.stripe_price_id
      product.quantity session[:cart][item.id.to_s]
    end
  end
end
