class Podcast < ActiveRecord::Base
	RECENT_DAYS = 14
	attr_protected
	after_initialize :default_values
	mount_uploader :audio, PodcastUploader
	validates_presence_of :date, :speaker, :title, :audio
	default_scope :order => 'date DESC', :limit => 30
	after_save :post_to_facebook

	def default_values
		self.date = DateTime.now if self.date.nil?
	end

	def post_to_facebook
    if !Setting.cached.facebook_access_token.blank? && !Setting.cached.facebook_group_id.blank? && !is_facebook_posted?
      Thread.new do
        begin
          FacebookGroupPoster.post_podcast(self.id)
        rescue => ex
          logger.error ex.message
        end
      end
    end
  end

	def description
		title + ' - ' + speaker
	end

	def is_recent?
		return (DateTime.now - date) <= RECENT_DAYS
	end
end
