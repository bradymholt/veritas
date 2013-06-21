class Renamecouples < ActiveRecord::Migration
def self.up
    rename_table :couples, :families
  end

 def self.down
    rename_table :families, :couples
 end
end
