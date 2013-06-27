class DefaultController < ApplicationController
 skip_before_filter :require_admin
 
 def index
 	@podcasts = Podcast.all
 	@families = Family.where(:is_member => true)
 	@signups = Signup.upcoming_available_for_signup

    respond_to do |format|
      format.html
      format.mobile
    end
  end
end
