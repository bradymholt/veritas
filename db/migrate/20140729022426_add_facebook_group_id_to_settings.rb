class AddFacebookGroupIdToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :facebook_group_id, :string
  end
end
