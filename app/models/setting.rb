class Setting < ActiveRecord::Base
  attr_protected
  mount_uploader :logo, LogoUploader
  mount_uploader :podcast_image, PodcastImageUploader

  def Setting.cached
	  Rails.cache.fetch("settings", :expires_in => 5.minutes) do
	    Setting.first
	  end
  end
end
