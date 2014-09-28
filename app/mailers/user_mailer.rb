class UserMailer < ActionMailer::Base
  default :from =>  "#{Setting.cached.group_name} <#{Setting.cached.contact_email}>"

  def custom_email(emails, subject, content)
    @content = content

     mail(:to => Setting.cached.contact_email,
     :cc => !Setting.cached.contact_email_cc.blank? ? Setting.cached.contact_email : '',
     :bcc => emails.join(', '),
     :subject => subject)
  end
  
  def visitor_email(contact)
    @contact = contact
 
    if @contact.email_addresses.length > 0
		 mail(:to => contact.email_addresses,
		 :cc => !Setting.cached.contact_email_cc.blank? ? Setting.cached.contact_email : '',
		 :subject => "Thanks for visiting #{Setting.cached.group_name}!")
	  end
  end

  def new_member_email(contact)
     @contact = contact
 
    if @contact.email_addresses.length > 0
     mail(:to => contact.email_addresses,
     :cc => !Setting.cached.contact_email_cc.blank? ? Setting.cached.contact_email : '',
     :subject => "Welcome to #{Setting.cached.group_name}!")
    end
  end

  def signup_email(signup, emails)
    @signup = signup
    mail(:to => !Setting.cached.contact_email_cc.blank? ? Setting.cached.contact_email : "noreply@#{Setting.cached.host_name}",
         :bcc => emails.join(', '),
         :subject => "#{Setting.cached.group_name}: Signup slots for #{@signup.title} are available")
  end
  
  def signup_reminder_email(contact, signup_slot, signup)
    @contact = contact
  	@slot = signup_slot
  	@signup = signup
  
  	if contact.email_addresses.length > 0
  		 mail(:to => contact.email_addresses,
  		 :cc => !Setting.cached.contact_email_cc.blank? ? Setting.cached.contact_email : '',
  		 :subject => "#{Setting.cached.group_name} Reminder: #{@signup.title} is coming up on #{@slot.date.strftime('%A')}")
	   end
  end

  def text_message(sms_gateway_email, message)
    @message = message
    mail(:to => sms_gateway_email, :subject => "#{Setting.cached.group_name}")
  end
end
