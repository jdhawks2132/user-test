class ExternalUsers::SessionsController < ApplicationController
  respond_to :json

  def create
    user =
      PrimaryUser.find_by(
        unique_url_hash: params[:unique_url_hash],
        access_code: params[:access_code],
      ) ||
        DelegateUser.find_by(
          primary_user_id:
            PrimaryUser.find_by(unique_url_hash: params[:unique_url_hash])&.id,
          access_code: params[:access_code],
        )

    if user
      session[:user_id] = user.id
      render json: {
               user_id: user.id,
               message: 'Logged in successfully.',
             },
             status: :ok
    else
      render json: {
               error: 'Invalid access code or URL.',
             },
             status: :unauthorized
    end
  end
end
