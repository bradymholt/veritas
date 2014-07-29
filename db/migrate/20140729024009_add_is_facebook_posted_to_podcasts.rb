class AddIsFacebookPostedToPodcasts < ActiveRecord::Migration
  def change
    add_column :podcasts, :is_facebook_posted, :boolean, :null => false, :default => true
    add_column :signup_slots, :is_facebook_posted, :boolean, :null => false, :default => true
  end
end
