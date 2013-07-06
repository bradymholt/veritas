class AddReminderSentToSignupSlot < ActiveRecord::Migration
  def change
    add_column :signup_slots, :reminder_sent, :boolean
  end
end
