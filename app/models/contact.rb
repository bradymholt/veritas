class Contact < ActiveRecord::Base
  attr_protected
  attr_accessor :send_welcome_email_on_save, :mark_initial_attendance_on_create, :attendance_first, :attendance_last, :attendance_count
  has_many :attendances
  has_many :signup_slots
  after_initialize :default_values
  after_create :mark_initial_attendance
  after_save :send_welcome_email
  mount_uploader :photo, ContactPhotoUploader
  validates_presence_of :last_name
  default_scope order('last_name')

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
    first_names = ([first_name, spouse_name].reject { |n| n.blank? }).join(' & ')
  end

  def type_name
    is_member ? 'Member' : 'Visitor'
  end

  def email_addresses
    emails = []
    
    if !email.blank?
      emails << email
    end

    if !spouse_email.blank?
      emails << spouse_email
    end

    emails.join(', ')
  end

  def has_email
    return !email.blank? || !spouse_email.blank?
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
  if @mark_initial_attendance_on_create == "1"
   Attendance.mark_attendance_last_sunday(self.id, true)
 end
end

def send_welcome_email
 if @send_welcome_email_on_save == "1"
  Thread.new do
    UserMailer.welcome_email(self).deliver
  end
end
end

def self.to_csv(contacts, options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    contacts.each do |contact|
      csv << contact.attributes.values_at(*column_names)
    end
  end
end

def self.upcoming_dates(contacts, up_to_date)
  dates = []
  contacts.each do |f|
    add_upcoming_date(f.anniversary, up_to_date, "Anniversary - #{f.last_name}", 'anniversary', f.id, dates)
    add_upcoming_date(f.birthday, up_to_date, "Birthday - #{f.first_name} #{f.last_name}", 'contact_birthday', f.id, dates)
    add_upcoming_date(f.spouse_birthday, up_to_date, "Birthday - #{f.spouse_name} #{f.last_name}", 'spouse_birthday', f.id, dates)
  end
  dates.sort { |a,b| a[:date] <=> b[:date] }
end

def self.next_date(date)
  next_date = Time.mktime(DateTime.now.year, date.month, date.day)
  if next_date < DateTime.now.to_date
    next_date = next_date + 1.year
  end
  next_date
end

def self.add_upcoming_date(date, up_to_date, description, type, contact_id, collection)
  if !date.nil?
    next_date = next_date(date)
    if  next_date <= up_to_date
      collection << { description: description, date: next_date, type: type, contact_id: contact_id}
    end
  end
end

def self.emails_men
  contacts = Contact.where(:is_active => true)
  emails = []
  contacts.reject { |c| c.email.blank? }.each { |h|
    if !h.first_name.blank?
      emails.push('"' + h.first_name + ' ' + h.last_name + '" <' + h.email + '>')
    else
      emails.push(h.email)
    end
  }

  emails.join(', ')
end

def self.emails_women
  contacts = Contact.where(:is_active => true)
  emails = []
  contacts.reject { |c| c.spouse_email.blank? }.each { |w|
    if !w.spouse_name.blank?
      emails.push('"' + w.spouse_name + ' ' + w.last_name + '" <' + w.spouse_email + '>')
    else
      emails.push(w.spouse_email)
    end
  }

  emails.join(', ')
end

def self.emails_all
  [Contact.emails_men, Contact.emails_women].join(', ')
end

def self.emails_visitors
  contacts = Contact.where(:is_member => false, :is_active => true)
  emails = []
  contacts.reject { |c| c.email.blank? }.each { |h|
    if !h.first_name.blank?
      emails.push('"' + h.first_name + ' ' + h.last_name + '" <' + h.email + '>')
    else
      emails.push(h.email)
    end
  }

  emails.join(', ')
end

private 

def fetch_attendance_summary
  if !self.new_record? && self.attendance_first.nil?
    attendance_summary = Attendance.where(:contact_id => self.id)
    .where('present = ?', true)
    .group(:contact_id)
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
