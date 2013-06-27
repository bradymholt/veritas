class Renamesignupdates < ActiveRecord::Migration
  def up
  	 rename_table :signup_dates, :signup_slots
  end

  def down
  	 rename_table :signup_slots, :signup_dates
  end
end
