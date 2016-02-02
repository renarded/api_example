class Api::V1::UsersController < ApiController

  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(permitted_params[:id])
    render json: user
  end

  private

  def permitted_params
    params.permit(:id, :user_name, :email, :first_name, :last_name)
  end
end