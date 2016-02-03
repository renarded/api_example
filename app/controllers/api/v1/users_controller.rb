class Api::V1::UsersController < ApiController

  skip_before_filter :current_user_logged, only: [:index, :show, :create]
  before_filter :is_format_type_correct, only: [:create, :update]
  before_filter :allow_modification, only: [:update, :destroy]

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

  def update
    if current_user_logged.update(permitted_params)
      render json: current_user_logged, status: 200
    else
      render json: { error: "Could not update user." }, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user_logged.destroy
      render json: { message: "User has been destroyed." }, status: 200
    else
      render json: { error: "Could not destroy user." }, status: 404
    end
  end

  private

  def permitted_params
    params.permit(:id, :user_name, :email, :first_name, :last_name)
  end

  def allow_modification
    if current_user_logged.id != permitted_params[:id].to_i
      render json: { error: "Not allowed." }, status: 401 
    end
  end
end