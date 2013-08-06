class ChangeAnnouncementsHtmlType < ActiveRecord::Migration
  def up
  	change_column :settings, :announcements_html, :text
  end

  def down
  	change_column :settings, :announcements_html, :string
  end
end
