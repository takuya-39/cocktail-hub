class UsersController < ApplicationController
  before_action :authenticate
  before_action :baria_admin_user, only: %i[destroy]
  before_action :set_user

  def show
    @relationshiops = @user.followings
  end

  def destroy
    @user.destroy
  end

  def user_show_posts
    @posts = @user.posts.all.page(params[:page]).per(10)
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
