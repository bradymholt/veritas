class Pctype < ActiveRecord::Migration
  def up
  	rename_column :phone_carrier_lookups, :type, :phone_type
  end

  def down
  end
end
