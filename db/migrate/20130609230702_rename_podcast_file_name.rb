class RenamePodcastFileName < ActiveRecord::Migration
  def up
  	rename_column :podcasts, :file_name, :audio
  end

  def down
  	rename_column :podcasts, :audio, :file_name
  end
end
