class AddLogoToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :logo, :string
  end
end
