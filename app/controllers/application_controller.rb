class ApplicationController < ActionController::API
  include ActionController::Cookies

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||=
      begin
        if session[:user_id]
          # Check if the user is a PrimaryUser
          PrimaryUser.find_by(id: session[:user_id]) ||
            # If not, check if the user is a DelegateUser
            DelegateUser.find_by(id: session[:user_id])
        end
      end
  end
end
