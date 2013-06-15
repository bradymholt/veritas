class Dropcontactqueues < ActiveRecord::Migration
  def up
  	drop_table :contact_queues
  end

  def down
  end
end
