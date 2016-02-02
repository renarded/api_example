class ApiController < ApplicationController

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do
      render json: { error: 'Not Found' }, status: 404
  end

  private
  
  def current_user_id
    user_id = request.headers["X-User"].to_i
  end
end