class Renamecoupleidforcontactqueue < ActiveRecord::Migration
  def up
  	rename_column :contact_queue_items, :couple_id, :family_id
  end

  def down
  end
end
