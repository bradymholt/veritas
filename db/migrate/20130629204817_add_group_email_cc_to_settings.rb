class AddGroupEmailCcToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :contact_email_cc, :boolean
  end
end
