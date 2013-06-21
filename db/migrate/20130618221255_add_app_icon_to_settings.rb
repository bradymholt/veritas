class AddAppIconToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :app_icon, :string
  end
end
