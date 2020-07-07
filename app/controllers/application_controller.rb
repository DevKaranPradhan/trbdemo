class ApplicationController < ActionController::Base
  before_action :authorized
  helper_method :current_user
  helper_method :logged_in?
  # SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def current_user   
    # byebug
    # decoded = JWT.decode(session[:token], SECRET_KEY)[0]
    # HashWithIndifferentAccess.new decoded
    if session[:token]
      decoded = JsonWebToken.decode(session[:token])
      puts "in apc==#{session[:token]} id #{decoded}"
      User.find_by(id: decoded[:user_id])
    else
      return nil
    end
  end
  
  def logged_in?
    !current_user.nil?
  end

  def authorized   
    redirect_to '/users' unless logged_in?
  end

end
