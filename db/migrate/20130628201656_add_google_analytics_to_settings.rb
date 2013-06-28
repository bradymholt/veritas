class AddGoogleAnalyticsToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :google_analytics_tracking_id, :string
  end
end
