class RenameFamiliesFields < ActiveRecord::Migration
  def up
  	rename_column :contacts, :husband_name, :first_name
    rename_column :contacts, :husband_email, :email
    rename_column :contacts, :husband_phone, :phone
    rename_column :contacts, :husband_birthday, :birthday
    rename_column :contacts, :wife_name, :spouse_name
    rename_column :contacts, :wife_email, :spouse_email
    rename_column :contacts, :wife_phone, :spouse_phone
    rename_column :contacts, :wife_birthday, :spouse_birthday
  end

  def down
  end
end
