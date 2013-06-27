class Podcast < ActiveRecord::Base
	RECENT_DAYS = 14
	attr_protected
	after_initialize :default_values
	mount_uploader :audio, PodcastUploader
	validates_presence_of :date, :speaker, :title, :audio
	default_scope :order => 'date DESC', :limit => 30

	def default_values
		self.date = DateTime.now if self.date.nil?
	end

	def description
		title + ' - ' + speaker
	end

	def is_recent?
		return (DateTime.now - date) <= RECENT_DAYS
	end
end
