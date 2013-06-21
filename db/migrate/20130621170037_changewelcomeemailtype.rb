class Changewelcomeemailtype < ActiveRecord::Migration
  def up
  	change_column :settings, :welcome_email_html, :text
  end

  def down
  	change_column :settings, :welcome_email_html, :string
  end
end
