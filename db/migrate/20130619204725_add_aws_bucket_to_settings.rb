class AddAwsBucketToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :aws_bucket_name, :string
    add_column :settings, :aws_access_key, :string
    add_column :settings, :aws_secret_access_key, :string
  end
end
