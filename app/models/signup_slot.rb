class SignupSlot < ActiveRecord::Base
  attr_accessible :date, :contact_id, :signup_id, :notes
  belongs_to :signup
  belongs_to :contact
  validates :date, :presence => true
  default_scope where('date >= ?', DateTime.now).order('date')

  def self.summary_by_signup
  	select('signup_id, max(date) as max_date, min(date) as min_date, count(id) as count_slots, sum(CASE WHEN contact_id IS NULL THEN 1 ELSE 0 END) as count_unslotted')
  	.group(:signup_id)
  end
end
