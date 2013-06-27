class Renamesettings < ActiveRecord::Migration
  def up
  	add_column :settings, :contact_queue_visitors_present_weeks, :integer
  	remove_column :settings, :contact_queue_visitors
  end

end
