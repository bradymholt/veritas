class Addcarriertype < ActiveRecord::Migration
  def up
  	add_column :phone_carrier_lookups, :type, :string
  end

  def down
  end
end
