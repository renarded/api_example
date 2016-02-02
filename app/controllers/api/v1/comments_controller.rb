class Api::V1::CommentsController < ApiController

  def index
    comments = Comment.where("post_id = :post_id",
                 { post_id: permitted_params[:post_id] })
    render json: comments
  end

  def show
    comment = Comment.find(permitted_params[:id])
    render json: comment
  end

  private

  def permitted_params
    params.permit(:id, :post_id, :content)
  end
end