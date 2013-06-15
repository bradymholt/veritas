class CreateContactQueues < ActiveRecord::Migration
  def change
    create_table :contact_queues do |t|

      t.timestamps
    end
  end
end
