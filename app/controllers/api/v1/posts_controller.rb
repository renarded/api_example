class Api::V1::PostsController < ApiController

  def index
    posts = Post.all
    render json: posts
  end

  private

  def permitted_params
    params.permit(:name, :content)
  end
end