class RemovesendReminderEmail < ActiveRecord::Migration
  def up
  	remove_column :signups, :send_reminder_email
  end

  def down
  end
end
