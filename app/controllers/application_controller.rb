class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile
  before_filter :require_login
  helper_method :mobile_device?

  private

  def prepare_for_mobile
    puts params[:mobile]
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

   def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  def require_login
    unless logged_in?
      redirect_to login_url
    end
  end

   def logged_in?
      !session[:logged_in].blank?
  end
  
end
