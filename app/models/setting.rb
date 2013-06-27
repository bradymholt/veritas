class Setting < ActiveRecord::Base
  attr_protected
  mount_uploader :logo, LogoUploader
  mount_uploader :app_icon, AppIconUploader
  mount_uploader :banner, BannerUploader

  def Setting.cached
	  Rails.cache.fetch("settings", :expires_in => 5.minutes) do
	    Setting.first
	  end
  end

  def is_google_calendar_integrated?
   return !self.google_calendar_username.blank? && !self.google_calendar_password.blank? 
  end
end
