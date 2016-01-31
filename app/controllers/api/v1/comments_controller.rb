class Api::V1::CommentsController < ApiController

  private

  def permitted_params
    params.permit(:content)
  end
end