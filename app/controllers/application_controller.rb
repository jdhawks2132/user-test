class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :set_current_user

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user
  end

  private

  def set_current_user
    @current_user ||=
      begin
        if session[:user_id]
          PrimaryUser.find_by(id: session[:user_id]) ||
            DelegateUser.find_by(id: session[:user_id])
        end
      end
  end
end
