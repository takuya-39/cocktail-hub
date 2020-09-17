class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @relationshiops = @user.followings
  end

  def followings
    @users = current_user.followings
  end

  def followers
    @users = current_user.followers
  end
end
