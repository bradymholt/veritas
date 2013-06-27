class RenameSignupDescription < ActiveRecord::Migration
  def up
  	rename_column :signups, :description, :details
  end

  def down
  	rename_column :signups, :details, :description
  end
end
