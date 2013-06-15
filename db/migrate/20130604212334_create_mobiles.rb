class CreateMobiles < ActiveRecord::Migration
  def change
    create_table :mobiles do |t|

      t.timestamps
    end
  end
end
