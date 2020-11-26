class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    following = current_user.follow(@user)

    if following.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: @user, notice: 'ユーザーをフォローしました') }
        format.js
      end
    else
      redirect_back(fallback_location: @user, notice: 'ユーザーのフォローに失敗しました')
    end
  end

  def destroy
    following = current_user.unfollow(@user)

    if following.destroy
      respond_to do |format|
        format.html { redirect_back(fallback_location: @user, notice: 'ユーザーのフォローを解除しました') }
        format.js
      end
    else
      redirect_back(fallback_location: @user, notice: 'ユーザーのフォロー解除に失敗しました')
    end
  end

  private

  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
end
