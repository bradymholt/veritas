class SessionsController < ApplicationController
  layout nil
  skip_before_filter :require_login
  skip_before_filter :require_admin

  def create
   if params[:password] == Setting.cached.admin_password
     session[:role] = 'admin'
     set_role_cookie
     redirect_to session[:login_return_to] || root_path
    elsif params[:password] == Setting.cached.user_password
     session[:role] = 'user'
     set_role_cookie
     redirect_to session[:login_return_to] || root_path
   else
    flash[:error] = "Invalid Password"
    redirect_to root_path
    end
    
   
  end

  def destroy
    session[:role] = nil
    session[:login_return_to] = nil
    cookies.delete :role
    redirect_to default_url
  end

  private

  def set_role_cookie
    if params[:remember_me]
      cookies.permanent.signed[:role] = session[:role]
    end
  end
end
