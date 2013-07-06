class AddRosterInactivateAfterWeeksToSettings < ActiveRecord::Migration
  def change
  	 add_column :settings, :roster_inactivate_after_no_attendance_weeks, :int
  end
end
