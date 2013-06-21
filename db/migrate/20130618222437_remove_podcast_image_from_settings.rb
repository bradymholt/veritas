class RemovePodcastImageFromSettings < ActiveRecord::Migration
  def up
    remove_column :settings, :podcast_image
  end

  def down
    add_column :settings, :podcast_image, :string
  end
end
