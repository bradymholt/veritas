class Contactqueuecolumns < ActiveRecord::Migration
  def change
  	 add_column :contact_queue_items, :couple_id, :integer
  	 add_column :contact_queue_items, :reason, :string
	 add_column :contact_queue_items, :is_completed, :boolean
	 add_column :contact_queue_items, :completed_date, :date
	 add_column :contact_queue_items, :completed_by, :string
	 add_column :contact_queue_items, :completed_notes, :string
  end
end
