class RemovePodcastDescriptonFromSettings < ActiveRecord::Migration
  def up
    remove_column :settings, :podcast_description
  end

  def down
    add_column :settings, :podcast_description, :string
  end
end
