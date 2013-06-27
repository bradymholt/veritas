class FamilyMailer < ActionMailer::Base
  default :from =>  "#{Setting.cached.group_name} <#{Setting.cached.contact_email}>"

  def welcome(family, host_name, password)
    @family = family
    @host = host_name
    @pwd = password

    if family.email_addresses.length > 0
		 mail(:to => family.email_addresses, :subject => "Welcome to #{Setting.cached.group_name}!")
	  end
  end
end
