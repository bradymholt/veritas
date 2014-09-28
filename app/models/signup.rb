class Signup < ActiveRecord::Base
  has_many :signup_slots, :dependent => :destroy
  attr_accessible :details, :send_signup_email_to_type, :post_to_facebook, :send_reminder_days, :title, :visible_admin_only, :signup_slots_attributes
  attr_accessor :send_signup_email_to_type, :post_to_facebook, :date_min, :date_max, :slot_count, :unslotted_count
  accepts_nested_attributes_for :signup_slots, :allow_destroy => true
  validates :title, :presence => true
  after_save :send_signup_email, :post_on_facebook

  def set_new_default_values
    self.send_reminder_days = 2 if new_record?
    self.post_to_facebook = true if new_record?
    self.send_signup_email_to_type = "members"
  end

  def send_signup_email
     if !@send_signup_email_to_type.blank? && self.visible_admin_only == false
      Thread.new do
        begin
          email_addresses = Contact.emails_by_type(@send_signup_email_to_type.to_sym)
          email_addresses.each_slice(20) {|email_batch|   #batches of 20
            UserMailer.signup_email(self, email_batch).deliver  
          }
        rescue => ex
          logger.error ex.message
        ensure
          ActiveRecord::Base.connection_pool.release_connection
        end
      end
    end
  end

  def post_on_facebook
    if @post_to_facebook == "1" && self.visible_admin_only == false
      Thread.new do
        begin
          FacebookGroupPoster.post_signup(self.id)
        rescue => ex
          logger.error ex.message
        ensure
          ActiveRecord::Base.connection_pool.release_connection
        end
      end
    end
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
