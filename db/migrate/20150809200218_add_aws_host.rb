class AddAwsHost < ActiveRecord::Migration
  def up
      add_column :settings, :aws_host_name, :string
  end

  def down
  end
end
