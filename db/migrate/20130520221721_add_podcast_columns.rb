class AddPodcastColumns < ActiveRecord::Migration
	 def change
	    add_column :podcasts, :date, :date
	    add_column :podcasts, :title, :string
	    add_column :podcasts, :speaker, :string
	    add_column :podcasts, :file_name, :string
	  end
end
