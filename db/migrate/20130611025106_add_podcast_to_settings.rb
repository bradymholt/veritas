class AddPodcastToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :podcast_title, :string
    add_column :settings, :podcast_description, :string
    add_column :settings, :podcast_image, :string
  end
end
