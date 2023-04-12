class PrimaryUsersController < ApplicationController
  respond_to :json

  def index
    primary_users = PrimaryUser.all
    render json: { primary_users: primary_users }, status: :ok
  end

  def create
    primary_user = PrimaryUser.new(primary_user_params)
    if primary_user.save
      render json: { primary_user: primary_user }, status: :created
    else
      render json: {
               errors: primary_user.errors.full_messages,
             },
             status: :unprocessable_entity
    end
  end

  def upload
    primary_users = []
    errors = []

    if params[:file]
      CSV.foreach(params[:file].path, headers: true) do |row|
        primary_user = PrimaryUser.new(primary_user_params(row))
        if primary_user.save
          primary_users << primary_user
        else
          errors << primary_user.errors.full_messages
        end
      end
      render json: {
               primary_users: primary_users,
               errors: errors,
             },
             status: :created
    else
      render json: { error: 'No file uploaded' }, status: :unprocessable_entity
    end
  end

  private

  def primary_user_params(input)
    if input.is_a?(ActionController::Parameters)
      input.permit(:first_name, :last_name, :email, :is_primary)
    else
      {
        first_name: input['first'],
        last_name: input['last'],
        email: input['email'],
        is_primary: true,
      }
    end
  end
end
