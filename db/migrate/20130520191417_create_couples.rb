class CreateCouples < ActiveRecord::Migration
  def change
    create_table :couples do |t|
    t.string   :last_name
    t.string   :address
    t.string   :city_state_zip
    t.string   :home_phone
    t.date     :anniversary
    t.string   :husband_name
    t.string   :husband_email
    t.string   :husband_phone
    t.date     :husband_birthday
    t.string   :wife_name
    t.string   :wife_email
    t.string   :wife_phone
    t.date     :wife_birthday
    t.text     :notes
    t.boolean  :is_member
    t.date     :member_date
    t.boolean  :is_active
    t.timestamps
    end
  end
end
