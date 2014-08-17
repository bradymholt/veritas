class Privatecontact2 < ActiveRecord::Migration
  def up
  	change_column :contacts, :is_active, :boolean, :default => true
  	change_column :contacts, :is_member, :boolean, :default => false
  	change_column :contacts, :is_private, :boolean, :default => false
  end

  def down
  end
end
