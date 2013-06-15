class Couple < ActiveRecord::Base
  attr_protected
  after_initialize :default_values
  after_create :mark_initial_attendance
  validates_presence_of :last_name

  def default_values
    self.is_active = true if self.is_active.nil?
    self.is_member = false if self.is_member.nil?
  end

  def mark_initial_attendance
    Attendance.mark_attendance_last_sunday(self.id, true, true)
  end

  def full_name
  	last_name + ', ' + husband_name + ' & ' + wife_name
  end

  def full_name_first
    husband_name + ' & ' + wife_name + ' ' + last_name
  end

  def last_attendance_date
    date = Attendance.where(:couple_id => self.id)
    .where('husband_present = ? OR wife_present = ?', true, true)
    .maximum('date')
    return date
  end

  def self.husband_emails
   couples = Couple.where(:is_active => true)
   emails = []
   couples.each { |c|
    if !c.husband_email.empty?
     emails.push('"' + c.husband_name + ' ' + c.last_name + '" <' + c.husband_email + '>')
   end
 }
 emails.join(', ')
end

def self.wife_emails
 couples = Couple.where(:is_active => true)
 emails = []
 couples.each { |c|
  if !c.wife_email.empty?
   emails.push('"' + c.wife_name + ' ' + c.last_name + '" <' + c.wife_email + '>')
 end
}
emails.join(', ')
end

def self.all_emails
 Couple.husband_emails + ', ' + Couple.wife_emails
end

end
