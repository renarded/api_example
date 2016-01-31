class ApiController < ApplicationController

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do
      render json: { error: 'not_found' }, status: 404
  end
end