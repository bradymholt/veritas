class Podcast < ActiveRecord::Base
	attr_protected
	after_initialize :default_values
	mount_uploader :audio, PodcastUploader
	validates_presence_of :date, :speaker, :title, :audio

	def default_values
		self.date = DateTime.now if self.date.nil?
	end

	def description
		title + ' - ' + speaker
	end
end
