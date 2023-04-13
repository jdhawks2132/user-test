class Api::V1::DelegateUsersController < ApiController
  def index
    delegate_users = DelegateUser.all
    render json: { delegate_users: delegate_users }, status: :ok
  end

  def create
    primary_user =
      PrimaryUser.find_by(unique_url_hash: params[:unique_url_hash])
    unless primary_user
      return(
        render json: { error: 'Primary user not found.' }, status: :not_found
      )
    end

    delegate_user = primary_user.build_delegate_user(delegate_user_params)
    if delegate_user.save
      render json: { delegate_user: delegate_user }, status: :created
    else
      render json: {
               errors: delegate_user.errors.full_messages,
             },
             status: :unprocessable_entity
    end
  end

  private

  def delegate_user_params
    params.require(:delegate_user).permit(:first_name, :last_name, :email)
  end
end
