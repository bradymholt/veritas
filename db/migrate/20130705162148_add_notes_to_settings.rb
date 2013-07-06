class AddNotesToSettings < ActiveRecord::Migration
  def change
  	add_column :settings, :announcements_html, :string
  end
end
