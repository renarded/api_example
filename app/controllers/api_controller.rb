class ApiController < ApplicationController

  before_filter :current_user_logged

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do
      render json: { error: 'Not Found' }, status: 404
  end

  skip_before_filter :verify_authenticity_token 

  def index
    routes = `rake routes`.split("\n").map{ |r| r.gsub(', ', ',').split(' ') }
    render json: routes
  end

  private
  
  def current_user_logged
    begin
      user = User.find(request.headers["X-User"].to_i)
    rescue
      render json: { error: "Wrong authentication" }, status: 401
    end
  end

  def is_format_type_correct
    if request.headers["Content-Type"] != "application/json"
      render json: { error: "Format type should be json." }, status: 415
    end
  end
end