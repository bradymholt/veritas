class RemoveSignupSlotsPerDateFromSignups < ActiveRecord::Migration
  def up
  	 remove_column :signups, :signup_slots_per_date
  end

  def down
  	 add_column :signups, :signup_slots_per_date, :integer
  end
end
