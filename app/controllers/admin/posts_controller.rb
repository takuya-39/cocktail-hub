class Admin::PostsController < ApplicationController
  before_action :authenticate, only: %i[index]
  before_action :baria_admin_user, only: %i[index]

  def index
    @posts = Post.all.page(params[:page]).per(10)
  end
end
