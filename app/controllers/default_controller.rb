class DefaultController < ApplicationController
 skip_before_filter :require_admin
 skip_before_filter :require_login
 helper_method :logged_in?

 
 def index
 	if !cookies.signed[:role].blank?
      session[:role] = cookies.signed[:role]
    end

    if logged_in?
	 	@contacts = Contact.where(:is_member => true, :is_active => true, :is_private => false)
	 	@signups = Signup.upcoming_available_for_signup

	 	if (!Setting.cached.google_calendar_enabled?)
	 		@upcoming_dates = Contact.upcoming_dates(@contacts, DateTime.now + 3.months)
	 	end
 	end

 	@podcasts = Podcast.all

 	if !logged_in? 
    respond_to do |format|
      format.html
      format.mobile {
      	if logged_in?
      		render :index
      	else
      		redirect_to login_url
      	end
      }
    end
  end
 end
end
