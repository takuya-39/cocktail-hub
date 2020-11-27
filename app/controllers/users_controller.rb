class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user

  def show
    @relationshiops = @user.followings
  end

  def followings
    @users = @user.followings.page(params[:page]).per(10).order(created_at: 'DESC')
  end

  def followers
    @users = @user.followers.page(params[:page]).per(10).order(created_at: 'DESC')
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
