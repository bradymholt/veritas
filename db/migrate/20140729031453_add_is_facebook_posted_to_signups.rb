class AddIsFacebookPostedToSignups < ActiveRecord::Migration
  def change
  	   remove_column :signup_slots, :is_facebook_posted
       add_column :signups, :is_facebook_posted, :boolean, :null => false, :default => true
 
  end
end
