class Api::V1::CommentsController < ApiController

  skip_before_filter :current_user_logged, only: [:index, :show]
  before_filter :is_format_type_correct, only: [:create]

  def index
    comments = Comment.where("post_id = :post_id",
                 { post_id: permitted_params[:post_id] })
    render json: comments
  end

  def show
    comment = Comment.find(permitted_params[:id])
    render json: comment
  end

  def create
    comment = Post.find(permitted_params[:post_id]).comments.new(permitted_params)
    comment.user_id = current_user_logged.id

    if comment.save
      render json: comment, status: 201
    else
      render json: { error: "Could not create comment." }, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.permit(:id, :post_id, :content)
  end
end