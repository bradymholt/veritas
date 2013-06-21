class AddSettingsForMail < ActiveRecord::Migration
  def up
  	add_column :settings, :smtp_server, :string
    add_column :settings, :smtp_username, :string
    add_column :settings, :smtp_password, :string
    add_column :settings, :smtp_port, :integer
    add_column :settings, :smtp_tls, :boolean
  end

  def down
  end
end
