class Api::V1::UsersController < ActionController::API
  def index
    @user = User.find_by(id: current_user)

    render json: @user
  end
end
