class Signup < ActiveRecord::Base
  has_many :signup_slots, :dependent => :destroy
  attr_accessible :details, :send_reminder_email, :send_reminder_email_days, :title, :visible_admin_only, :signup_slots_attributes
  attr_accessor :date_min, :date_max, :slot_count, :unslotted_count
  accepts_nested_attributes_for :signup_slots, :allow_destroy => true
  validates :title, :presence => true
  after_initialize :default_values


  def default_values
    self.send_reminder_email = true if self.send_reminder_email.nil?
    self.send_reminder_email_days = 2 if self.send_reminder_email_days.nil?
  end

  def self.upcoming_available_for_signup()
    upcoming_slot_summaries = SignupSlot.summary_by_signup.having('max_date >= ?', DateTime.now)
    upcoming = Signup.where(:visible_admin_only => false).where('id IN (?)', upcoming_slot_summaries.map { |s| s.signup_id }) 
    Signup.assimilate_summaries(upcoming, upcoming_slot_summaries)
  end

  def self.fetch_summaries(signups)
  	summaries = SignupSlot.summary_by_signup 
  		.where('signup_id IN (?)', signups.map { |s| s.id })
  		.group('signup_id')
  	
    return assimilate_summaries(signups, summaries)
  end

  def self.assimilate_summaries(signups, summaries)
    indexed_summary = summaries.index_by { |s| s[:signup_id] }
    signups.each {|s|
      signup_summary = indexed_summary[s.id]
      if !signup_summary.nil?
        s.date_min = indexed_summary[s.id][:min_date].to_date
        s.date_max = indexed_summary[s.id][:max_date].to_date
        s.slot_count = indexed_summary[s.id][:count_slots].to_i
        s.unslotted_count = indexed_summary[s.id][:count_unslotted].to_i
      else
        s.slot_count = 0
      end
    }
  end
end
