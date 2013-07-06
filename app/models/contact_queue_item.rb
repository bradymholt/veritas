class ContactQueueItem < ActiveRecord::Base
	attr_protected
	belongs_to :contact
	after_initialize :default_values
	 
	def default_values
		self.is_completed = false if self.is_completed.nil?
	end
end
