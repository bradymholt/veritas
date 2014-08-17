class Privatecontact < ActiveRecord::Migration
  def up
  	add_column :contacts, :is_private, :boolean
  end

  def down
  end
end
