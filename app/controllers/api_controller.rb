class ApiController < ApplicationController
  before_action :authenticate_user!

  private

  def authenticate_user!
    unless @current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
