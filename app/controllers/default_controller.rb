class DefaultController < ApplicationController
 skip_before_filter :require_admin
 
 def index
 	@podcasts = Podcast.all
 	@contacts = Contact.where(:is_member => true, :is_active => true)
 	@signups = Signup.upcoming_available_for_signup

 	if (Setting.cached.google_calendar_enabled?)
 		@upcoming_dates = Contact.upcoming_dates(@contacts, DateTime.now + 3.months)
 	end

    respond_to do |format|
      format.html
      format.mobile
    end
  end
end
