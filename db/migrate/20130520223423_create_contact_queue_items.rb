class CreateContactQueueItems < ActiveRecord::Migration
  def change
    create_table :contact_queue_items do |t|

      t.timestamps
    end
  end
end
