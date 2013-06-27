class RenameSlotsColumn < ActiveRecord::Migration
  def up
  		rename_column :signups, :signup_slots, :signup_slots_per_date
  end

  def down
  	rename_column :signups, :signup_slots_per_date, :signup_slots
  end
end
