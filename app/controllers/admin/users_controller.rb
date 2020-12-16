class Admin::UsersController < ApplicationController
  before_action :authenticate, only: %i[index]
  before_action :baria_admin_user, only: %i[index]

  def index
    @users = User.all.page(params[:page]).per(10)
  end
end
