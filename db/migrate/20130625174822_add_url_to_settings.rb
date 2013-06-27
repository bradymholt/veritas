class AddUrlToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :url, :string
    add_column :settings, :contact_queue_visitors, :boolean
    add_column :settings, :contact_queue_members_absent_weeks, :integer
     add_column :settings, :contact_queue_notify_email, :string
  end
end
