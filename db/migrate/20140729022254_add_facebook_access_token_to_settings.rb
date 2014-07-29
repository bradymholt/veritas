class AddFacebookAccessTokenToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :facebook_access_token, :string
  end
end
