class Carrierlookupapi < ActiveRecord::Migration
  def up
  	add_column :settings, :carrier_lookup_api_key, :string
  end

  def down
  end
end
