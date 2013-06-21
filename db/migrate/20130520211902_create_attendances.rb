class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :family_id
      t.date	:date
      t.boolean :husband_present
      t.boolean :wife_present
      t.timestamps
    end
  end
end
