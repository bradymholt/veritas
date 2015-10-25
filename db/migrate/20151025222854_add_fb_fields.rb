class AddFbFields < ActiveRecord::Migration
  def up
      add_column :settings, :facebook_app_id, :string
      add_column :settings, :facebook_app_secret, :string
  end

  def down
  end
end
