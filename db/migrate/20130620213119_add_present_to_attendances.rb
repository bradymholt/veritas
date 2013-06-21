class AddPresentToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :present, :boolean
    execute "UPDATE attendances SET present = 1 WHERE husband_present = 1 OR wife_present = 1"
    remove_column :attendances, :husband_present
    remove_column :attendances, :wife_present
  end
end
