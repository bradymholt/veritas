class Attendance < ActiveRecord::Base
	attr_protected
	before_save :strip_time_from_date
	belongs_to :contact
	
	def self.mark_attendance_last_sunday(contact_id, present)
		last_sunday = DateTime.now - DateTime.now.wday
		Attendance.mark_attendance(contact_id, last_sunday, present)
	end

	def self.mark_attendance(contact_id, date, present)
		attendance = Attendance.where(:date => date, :contact_id => contact_id).first_or_initialize
	    attendance.present = present
	    attendance.save
	end

	def as_json(options={})
  		{ :contact_id => self.contact_id, :date => self.date, :present => self.present }
	end

	def strip_time_from_date
		self.date = self.date.to_date
	end

	def self.attendance_last
      last = Contact.joins("LEFT JOIN attendances ON attendances.contact_id = contacts.id")
      .where("attendances.id IS NULL OR attendances.present = ?", true)
      .group('contacts.id, contacts.last_name')
      .select('contacts.*, max(attendances.date) as last_date')
      return last
	  end

	  def self.attendance_counts_all(since_date)
	    counts = Attendance.where(:present => true).where('date >= ?', since_date).group(:date).select('date, count(*) as count')
	  end

	  def self.attendance_counts_members(since_date)
	    counts = Attendance.joins(:contact).where(:present => true).where('contacts.is_member = ?', true).where('date >= ?', since_date).group(:date).select('date, count(*) as count')
	  end

	  def self.attendance_counts_visitors(since_date)
	    counts = Attendance.joins(:contact).where(:present => true).where('contacts.is_member = ?', false).where('date >= ?', since_date).group(:date).select('date, count(*) as count')
	  end
end
