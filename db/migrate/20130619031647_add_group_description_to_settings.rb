class AddGroupDescriptionToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :group_description, :string
  end
end
