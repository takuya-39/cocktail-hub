class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後、posts/indexに移動する
  def after_sign_in_path_for(_resource)
    root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [%i[image], :username, :profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [%i[image], :username, :profile])
  end
end
