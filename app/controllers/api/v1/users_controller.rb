class Api::V1::UsersController < ApiController

  def index
    users = User.all
    render json: users
  end


  private

  def permitted_params
    params.permit(:user_name, :email, :first_name, :last_name)
  end
end