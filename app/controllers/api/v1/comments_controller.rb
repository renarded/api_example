class Api::V1::CommentsController < ApiController

  skip_before_filter :current_user_logged, only: [:index, :show]
  before_filter :is_format_type_correct, only: [:create, :update]
  before_filter :allow_modification, only: [:update, :destroy]

  def index
    if permitted_params[:user_id].nil?
      comments = Comment.where("post_id = :post_id",
          { post_id: permitted_params[:post_id] })
    else
      comments = Comment.where("post_id = :post_id AND user_id = :user_id",
          { post_id: permitted_params[:post_id], user_id: permitted_params[:user_id] })
    end
    
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

  def update
    comment = Comment.find(permitted_params[:id])

    if comment.update(permitted_params)
      render json: comment, status: 200
    else
      render json: { error: "Could not update comment." }, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(permitted_params[:id])
    
    if comment.destroy
      render json: { message: "Comment has been destroyed." }, status: 200
    else
      render json: { error: "Could not destroy comment." }, status: 404
    end
  end

  private

  def permitted_params
    params.permit(:id, :post_id, :user_id, :content)
  end

  def allow_modification
    comment = Comment.find(permitted_params[:id])

    if ( (current_user_logged.id != comment.user_id) ||
       (Post.find(permitted_params[:post_id]).id != comment.post_id) ) 
      render json: { error: "Not allowed." }, status: 401
    end
  end
end