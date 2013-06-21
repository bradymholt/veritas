class AddGoogleCalendarPasswordToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :google_calendar_password, :string
  end
end
