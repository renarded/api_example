class Api::V1::PostsController < ApiController

  def index
    #posts = Post.where("user_id = :user_id", { user_id: current_user_id })
    posts = Post.all
    render json: posts
  end

  def show
    post = Post.find(permitted_params[:id])
    render json: post
  end

  private

  def permitted_params
    params.permit(:id, :name, :content)
  end
end