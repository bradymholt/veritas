class AddSettings < ActiveRecord::Migration
  def up
  	add_column :settings, :group_name, :string
  end

  def down
  	remove_column :settings, :group_name
  end
end
