class Attendance < ActiveRecord::Base
	attr_protected
	before_save :strip_time_from_date
	belongs_to :family
	
	def self.mark_attendance_last_sunday(family_id, present)
		last_sunday = DateTime.now - DateTime.now.wday
		Attendance.mark_attendance(family_id, last_sunday, present)
	end

	def self.mark_attendance(family_id, date, present)
		attendance = Attendance.where(:date => date, :family_id => family_id).first_or_initialize
	    attendance.present = present
	    attendance.save
	end

	def as_json(options={})
  		{ :family_id => self.family_id, :date => self.date, :present => self.present }
	end

	def strip_time_from_date
		self.date = self.date.to_date
	end
end
