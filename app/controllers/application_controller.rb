# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_cart, :load_cart
  include Pundit::Authorization

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :contact_number, :address, :image)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :contact_number, :address, :image)
    end
  end

  private

  def initialize_cart
    session[:cart] ||= {}
  end

  def load_cart
    @cart = Product.find(session[:cart].keys)
  end
end
