class ExternalUsers::SessionsController < ApplicationController
  def create
    user = find_user_by_url_and_access_code

    if user
      session[:user_id] = user.id
      render json: {
               user: user,
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

  def destroy
    session.delete(:user_id)
    @current_user = nil

    render json: { message: 'Logged out successfully.' }, status: :ok
  end

  private

  def find_user_by_url_and_access_code
    find_primary_user || find_delegate_user
  end

  def find_primary_user
    PrimaryUser.find_by(
      unique_url_hash: params[:unique_url_hash],
      access_code: params[:access_code],
    )
  end

  def find_delegate_user
    primary_user =
      PrimaryUser.find_by(unique_url_hash: params[:unique_url_hash])
    if primary_user
      DelegateUser.find_by(
        primary_user_id: primary_user&.id,
        access_code: params[:access_code],
      )
    end
  end
end
