class Family < ActiveRecord::Base
  attr_protected
  attr_accessor :send_welcome_email, :mark_initial_attendance_on_create
  after_initialize :default_values
  after_create :mark_initial_attendance
  mount_uploader :photo, FamilyPhotoUploader
  validates_presence_of :last_name


  def default_values
    self.is_active = true if self.is_active.nil?
    self.is_member = false if self.is_member.nil?
    self.mark_initial_attendance_on_create = true if self.mark_initial_attendance_on_create.nil? && new_record?
    self.send_welcome_email = true if self.send_welcome_email.nil? && new_record?
  end

  def full_name
    full_name = last_name
    if !self.first_names.blank?
      full_name += (', ' + self.first_names)
    end
    full_name
  end

  def full_name_first 
    full_name = first_names
    if !full_name.blank?
      full_name += ' '
    end

    full_name += last_name
    full_name
  end

  def first_names
    first_names = ([husband_name, wife_name].reject { |n| n.blank? }).join(' & ')
  end

  def last_attendance_date
    date = Attendance.where(:family_id => self.id)
    .where('present = ?', true)
    .maximum('date')
    return date
  end

  def mark_initial_attendance
    if @mark_initial_attendance_on_create
     Attendance.mark_attendance_last_sunday(self.id, true)
   end
 end

 def self.husband_emails
   families = Family.where(:is_active => true)
   emails = []
   families.reject { |c| c.husband_email.blank? }.each { |h|
    if !h.husband_name.blank?
     emails.push('"' + h.husband_name + ' ' + h.last_name + '" <' + h.husband_email + '>')
   else
     emails.push(h.husband_email)
   end
 }

 emails.join(', ')
end

def self.wife_emails
 families = Family.where(:is_active => true)
   emails = []
   families.reject { |c| c.wife_email.blank? }.each { |w|
    if !w.wife_name.blank?
     emails.push('"' + w.wife_name + ' ' + w.last_name + '" <' + w.wife_email + '>')
   else
     emails.push(w.wife_email)
   end
 }

 emails.join(', ')
end

def self.all_emails
 [Family.husband_emails, Family.wife_emails].join(', ')
end

end
