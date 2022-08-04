# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :contact_number, :address, :image)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :contact_number, :address, :image)}
  end
end
