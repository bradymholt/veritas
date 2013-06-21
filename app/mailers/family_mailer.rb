class FamilyMailer < ActionMailer::Base
  default :from =>  "#{Setting.cached.group_name} <#{Setting.cached.contact_email}>"

  def welcome(family, host)
    @family = family
    @host = host
    @pwd = Setting.cached.user_password
    
    emails = []
    if !@family.husband_email.blank?
    	emails << @family.husband_email
    end
    if !@family.wife_email.blank?
    	emails << @family.wife_email
    end

    if emails.length > 0
		 mail(:to => emails.join(', '), :subject => "Welcome to #{Setting.cached.group_name}!")
	end
  end
end
