class AddPasswordToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :user_password, :string
  end
end
