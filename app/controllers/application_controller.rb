# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_cart
  before_action :load_cart

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::RoutingError, with: :error_occurred

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

  def user_not_authorized
    flash[:alert] = 'User is not authorized for this action.'
    redirect_to root_path
  end

  def record_not_found
    flash[:alert] = 'Required record is not available.'
    redirect_to root_path
  end

  def error_occurred
    flash[:alert] = 'Routing does not match for this request.'
    redirect_to root_path
  end

  private

  def initialize_cart
    session[:cart] ||= {}
  end

  def load_cart
    @cart = Product.find(session[:cart].keys)
  end
end
