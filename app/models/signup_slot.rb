class SignupSlot < ActiveRecord::Base
  attr_accessible :date, :family_id, :signup_id, :notes
  belongs_to :signup
  belongs_to :family
  validates :date, :presence => true

  def self.summary_by_signup
  	select('signup_id, max(date) as max_date, min(date) as min_date, count(id) as count_slots, sum(CASE WHEN family_id IS NULL THEN 1 ELSE 0 END) as count_unslotted')
  	.group(:signup_id)
  end
end
