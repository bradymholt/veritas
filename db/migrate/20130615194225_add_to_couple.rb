class AddToCouple < ActiveRecord::Migration
  def up
  	add_column :couples, :photo, :string
  end

  def down
  	remove_column :couples, :photo
  end
end
