class Api::V1::PostsController < ApiController

  private

  def permitted_params
    params.permit(:name, :content)
  end
end