class AddBannerToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :banner, :string
  end
end
