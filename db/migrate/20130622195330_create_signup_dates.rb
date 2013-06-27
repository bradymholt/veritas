class CreateSignupDates < ActiveRecord::Migration
  def change
    create_table :signup_dates do |t|
      t.integer :signup_id
      t.date :date
      t.integer :family_id

      t.timestamps
    end
  end
end
