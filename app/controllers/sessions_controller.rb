class SessionsController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :require_admin

  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    stripped_password = params[:password] 
    if stripped_password == Setting.cached.admin_password
     session[:role] = 'admin'
     redirect_to session[:login_return_to] || familes_path
   elsif stripped_password == Setting.cached.user_password
     session[:role] = 'user'
     redirect_to session[:login_return_to] || root_path
   else
    flash.now[:error] = "Invalid Password"
    render :new
  end

end

def destroy
  session[:role] = nil
  session[:login_return_to] = nil
  redirect_to :login
end
end
