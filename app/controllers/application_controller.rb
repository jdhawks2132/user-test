class ApplicationController < ActionController::API
  include ActionController::Cookies

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= PrimaryUser.find(session[:user_id]) if session[:user_id]
  end
end
