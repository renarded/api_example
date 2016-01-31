class Api::V1::CommentsController < ApiController

  def index
    comments = Comment.all
    render json: comments
  end

  private

  def permitted_params
    params.permit(:content)
  end
end