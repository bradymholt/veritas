class RenameUrlOnSettings < ActiveRecord::Migration
  def up
  	rename_column :settings, :url, :host_name
  end

  def down
  	rename_column :settings, :host_name, :url 
  end
end
