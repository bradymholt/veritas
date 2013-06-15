class CreateDemos < ActiveRecord::Migration
  def up
    create_table :demos do |t|

      t.timestamps
    end
  end

  def down
  	drop_table :demos
  end
end
