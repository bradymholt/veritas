class Family < ActiveRecord::Base
  attr_protected
  attr_accessor :send_welcome_email_on_save, :mark_initial_attendance_on_create, :attendance_first, :attendance_last, :attendance_count
  has_many :signup_slots
  after_initialize :default_values
  after_create :mark_initial_attendance
  after_save :send_welcome_email
  mount_uploader :photo, FamilyPhotoUploader
  validates_presence_of :last_name
  default_scope where(:is_active => true).order('last_name')

  def default_values
    self.is_active = true if self.is_active.nil?
    self.is_member = false if self.is_member.nil?
    self.mark_initial_attendance_on_create = true if self.mark_initial_attendance_on_create.nil? && new_record?
    self.send_welcome_email_on_save = true if self.send_welcome_email_on_save.nil? && new_record?
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

  def email_addresses
    emails = []
    
    if !husband_email.blank?
      emails << husband_email
    end

    if !wife_email.blank?
      emails << wife_email
    end

    emails.join(', ')
  end

  def last_attendance_date
    fetch_attendance_summary
    return self.attendance_last
  end

  def first_attendance_date
   fetch_attendance_summary
   return self.attendance_first
 end

 def count_attendance
  fetch_attendance_summary
  return self.attendance_count
end

def mark_initial_attendance
  if @mark_initial_attendance_on_create
   Attendance.mark_attendance_last_sunday(self.id, true)
  end
end

 def send_welcome_email
   if @send_welcome_email_on_save
      FamilyMailer.welcome(self, Setting.cached.host_name, Setting.cached.user_password).deliver
    end
 end

 def self.to_csv(families, options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      families.each do |family|
        csv << family.attributes.values_at(*column_names)
      end
    end
 end

def self.husband_emails
 families = Family.all
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
 families = Family.all
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

private 

def fetch_attendance_summary
  if !self.new_record? && self.attendance_first.nil?
    attendance_summary = Attendance.where(:family_id => self.id)
    .where('present = ?', true)
    .group(:family_id)
    .select('max(date) as max_date, min(date) as min_date, count(*) as count')
    .first

    if !attendance_summary.nil?
      self.attendance_first = attendance_summary.min_date.to_date
      self.attendance_last = attendance_summary.max_date.to_date
      self.attendance_count = attendance_summary.count
    end

  end
end

end
