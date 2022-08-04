# frozen_string_literal: true

module CartsHelper
  def total(cart)
    total_price ||= 0
    cart.each do |cart_item|
      total_price += (session[:cart][cart_item.id.to_s]).to_i * cart_item.price.to_i
    end
    total_price
  end
end
