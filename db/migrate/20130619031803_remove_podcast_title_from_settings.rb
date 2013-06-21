class RemovePodcastTitleFromSettings < ActiveRecord::Migration
  def up
    remove_column :settings, :podcast_title
  end

  def down
    add_column :settings, :podcast_title, :string
  end
end
