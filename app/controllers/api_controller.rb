class ApiController < ApplicationController

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do
      render json: { error: 'Not Found' }, status: 404
  end
end