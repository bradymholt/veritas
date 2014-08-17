class Welcomeemail < ActiveRecord::Migration
  def up
  	rename_column :settings, :welcome_email_html, :visitor_email_html
  	add_column :settings, :new_member_email_html, :text
  end

  def down
  end
end
