class ApplicationController < ActionController::Base
  layout 'standard'
  include Devise::Controllers::Helpers
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  helper_method :sort_column, :sort_direction
  include ApplicationHelper
end
