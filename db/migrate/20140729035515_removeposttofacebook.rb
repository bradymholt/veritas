class Removeposttofacebook < ActiveRecord::Migration
  def up
  	  	   remove_column :signups, :is_facebook_posted
  end

  def down
  end
end
