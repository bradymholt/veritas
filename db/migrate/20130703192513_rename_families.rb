class RenameFamilies < ActiveRecord::Migration
  def up
  	 rename_table :families, :contacts
  	 rename_column :attendances, :family_id, :contact_id
  	 rename_column :contact_queue_items, :family_id, :contact_id
  	 rename_column :signup_slots, :family_id, :contact_id
  end

  def down
  end
end
