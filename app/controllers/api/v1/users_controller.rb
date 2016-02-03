class Api::V1::UsersController < ApiController

  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(permitted_params[:id])
    render json: user
  end

  def create
    user = User.new(permitted_params)
    if user.save
      render json: user, status: 201
    else
      render json: { error: "Could not create user." }, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.permit(:id, :user_name, :email, :first_name, :last_name)
  end
end