class Phonecarriers < ActiveRecord::Migration
  def up
  	create_table :phone_carrier_lookups do |t|
    t.string   :phone_number
    t.string   :carrier
    t.timestamps
    end
  end

  def down
  end
end
