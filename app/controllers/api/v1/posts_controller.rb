class Api::V1::PostsController < ApiController

  skip_before_filter :current_user_logged, only: [:index, :show]
  before_filter :is_format_type_correct, only: [:create, :update]

  def index
    if permitted_params[:user_id].nil?
      posts = Post.all 
    else
      posts = Post.where("user_id = :user_id", {user_id: permitted_params[:user_id] })
    end
    render json: posts
  end

  def show
    post = Post.find(permitted_params[:id])
    render json: post
  end

  def create
    post = current_user_logged.posts.new(permitted_params)

    if post.save
      render json: post
    else
      render json: { error: "Could not create post." }, status: :unprocessable_entity
    end
  end

  def update
    post = Post.find(permitted_params[:id])

    if !current_user_logged.posts.include?(post)
      render json: { error: "Not allowed." }, status: 401 and return
    end 
    if post.update(permitted_params)
      render json: post, status: 200
    else
      render json: { error: "Could not update post." }, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.permit(:id, :name, :content, :user_id)
  end
end