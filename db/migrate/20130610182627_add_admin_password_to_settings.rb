class AddAdminPasswordToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :admin_password, :string
  end
end
