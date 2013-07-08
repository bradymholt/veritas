class SessionsController < ApplicationController
  layout nil
  skip_before_filter :require_login
  skip_before_filter :require_admin

  def new
    if !cookies.signed[:role].blank?
      session[:role] = cookies.signed[:role]
      redirect_to session[:login_return_to] || root_path
    else
      respond_to do |format|
        format.html # new.html.erb
      end
    end
  end

  def create
    if params[:password] == Setting.cached.admin_password
     session[:role] = 'admin'
     set_role_cookie
     redirect_to session[:login_return_to] || root_path
   #elsif params[:password] == Setting.cached.user_password
    elsif !params[:password].blank? && params[:password].length > 0
     session[:role] = 'user'
     set_role_cookie
     redirect_to session[:login_return_to] || root_path
   else
    flash.now[:error] = "Invalid Password"
    render :new
    end
    
   
  end

  def destroy
    session[:role] = nil
    session[:login_return_to] = nil
    cookies.delete :role
    redirect_to :login
  end

  private

  def set_role_cookie
    if params[:remember_me]
      cookies.permanent.signed[:role] = session[:role]
    end
  end
end
