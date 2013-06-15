class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|

      t.timestamps
    end
  end
end
