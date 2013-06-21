class ApplicationController < ActionController::Base
  before_filter :prepare_for_mobile
  before_filter :require_login
  before_filter :require_admin
  protect_from_forgery
  helper_method :mobile_device?, :is_admin?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

  def require_login
    unless logged_in?
      session[:login_return_to] = request.path
      redirect_to login_url
    end
  end

  def require_admin
    unless is_admin?
      session[:login_return_to] = request.path
      redirect_to login_url
    end
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
    end
  end

  def logged_in?
      is_admin? || is_user?
  end

  def is_admin?
     session[:role] == 'admin'
  end

  def is_user?
     session[:role] == 'user'
  end
  
end
