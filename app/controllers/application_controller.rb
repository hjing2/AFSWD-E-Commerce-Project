class ApplicationController < ActionController::Base
  helper_method :current_cart

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, addresses_attributes: [:address_line, :city, :province_id, :postal_code, :country]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, addresses_attributes: [:address_line, :city, :province_id, :postal_code, :country]])
  end

  def current_cart
    @current_cart ||= session[:cart] ||= {}
  end
end
