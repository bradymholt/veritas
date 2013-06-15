class Attendance < ActiveRecord::Base
	attr_protected
	before_save :strip_time_from_date
	belongs_to :couple
	
	def self.mark_attendance_last_sunday(couple_id, husband_present, wife_present)
		last_sunday = DateTime.now - DateTime.now.wday
		Attendance.mark_attendance(couple_id, last_sunday, husband_present, wife_present)
	end

	def self.mark_attendance(couple_id, date, husband_present, wife_present)
		attendance = Attendance.where(:date => date, :couple_id => couple_id).first_or_initialize
	    attendance.husband_present = husband_present
	    attendance.wife_present = wife_present
	    attendance.save
	end

	def as_json(options={})
  		{ :couple_id => self.couple_id, :date => self.date, :husband_present => self.husband_present, :wife_present => self.wife_present }
	end

	def strip_time_from_date
		self.date = self.date.to_date
	end
end
