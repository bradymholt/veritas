class Setting < ActiveRecord::Base
  attr_protected
  mount_uploader :logo, LogoUploader
  mount_uploader :app_icon, AppIconUploader

  def Setting.cached
	  Rails.cache.fetch("settings", :expires_in => 5.minutes) do
	    Setting.first
	  end
  end
end
