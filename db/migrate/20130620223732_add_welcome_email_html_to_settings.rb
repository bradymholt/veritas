class AddWelcomeEmailHtmlToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :welcome_email_html, :string
  end
end
