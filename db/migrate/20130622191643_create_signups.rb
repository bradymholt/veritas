class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :title
      t.string :description
      t.boolean :send_reminder_email
      t.integer :send_reminder_email_days
      t.boolean :visible_admin_only
      t.integer :signup_slots

      t.timestamps
    end
  end
end
