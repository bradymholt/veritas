class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|

      t.timestamps
    end
  end
end
