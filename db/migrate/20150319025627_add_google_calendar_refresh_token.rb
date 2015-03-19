class AddGoogleCalendarRefreshToken < ActiveRecord::Migration
   def change
    add_column :settings, :google_calendar_refresh_token, :string
  end
end
