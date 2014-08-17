class SendReminderEmailDays < ActiveRecord::Migration
  def up
  	rename_column :signups, :send_reminder_email_days, :send_reminder_days
  end

  def down
  end
end
