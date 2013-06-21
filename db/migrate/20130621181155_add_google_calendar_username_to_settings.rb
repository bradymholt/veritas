class AddGoogleCalendarUsernameToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :google_calendar_username, :string
  end
end
