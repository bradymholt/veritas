class AddNotesToSignupSlots < ActiveRecord::Migration
  def change
    add_column :signup_slots, :notes, :string
  end
end
