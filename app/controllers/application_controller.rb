class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後、ユーザーのマイプロフィールに移動する
  def after_sign_in_path_for(_resource)
    user_path(id: current_user.id)
  end

  # ログアウト後、ログイン画面に移動する
  def after_sign_out_path_for(_resource_or_scope)
    login_path
  end

  # 管理ユーザーかどうかチェックし、管理ユーザーなら編集、削除ができないという警告を表示する
  def check_admin
    email = resource&.email || params[:user][:email].downcase
    redirect_to user_path(id: current_user.id), notice: '管理ユーザーの編集、削除はできません' if email == 'admin@example.com'
  end

  # ゲストかどうかチェックし、ゲストなら編集、削除ができないという警告を表示する
  def check_guest
    email = resource&.email || params[:user][:email].downcase
    redirect_to user_path(id: current_user.id), notice: 'ゲストユーザーの編集、削除はできません' if email == 'guest@example.com'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [%i[image], :username, :profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [%i[image], :username, :profile])
  end

  def authenticate
    redirect_to login_path unless user_signed_in?
  end
end
