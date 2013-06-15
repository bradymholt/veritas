class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @session }
    end
  end

  # POST /sessions
  # POST /sessions.json
  def create
   if params[:password] == Setting.cached.admin_password
     session[:logged_in] = 'true'
     redirect_to :couples
    else
      flash[:error] = "Invalid Password"
      redirect_to login_path
    end

  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    session[:logged_in] = nil
    redirect_to :login
  end
end
