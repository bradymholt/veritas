class AddiTunesLinkToSettings < ActiveRecord::Migration
  def up
  	add_column :settings, :podcast_itunes_url, :string
  	rename_column :settings, :roster_inactivate_after_no_attendance_weeks, :contacts_inactivate_after_no_attendance_weeks
  end

  def down
  end
end
