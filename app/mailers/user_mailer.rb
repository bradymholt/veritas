class UserMailer < ActionMailer::Base
  default :from =>  "#{Setting.cached.group_name} <#{Setting.cached.contact_email}>"

  def welcome_email(contact)
    @contact = contact
 
    if @contact.email_addresses.length > 0
		 mail(:to => contact.email_addresses,
		 :cc => !Setting.cached.contact_email_cc.blank? ? Setting.cached.contact_email : '',
		 :subject => "Welcome to #{Setting.cached.group_name}!")
	  end
  end

  def signup_email(signup, send_to_index)
    @signup = signup
    send_to = Signup::SEND_SIGNUP_EMAIL_TO[send_to_index]
    email_to = ''

    if send_to == 'Everyone'
      email_to = Contact.emails_all
    elsif send_to == 'Men'
       email_to = Contact.emails_men
    elsif send_to == 'Women' 
       email_to = Contact.emails_women
    elsif send_to == 'Visitors'
       email_to = Contact.emails_visitors
    end

    if !email_to.blank?
       mail(:to => Setting.cached.contact_email,
       :bcc => email_to,
       :subject => "#{Setting.cached.group_name}: Signup slots for #{@signup.title} are available")
     end
  end
  
  def signup_reminder_email(signup_slot)
  	@slot = signup_slot
  	@signup = signup_slot.signup
  	@contact = signup_slot.contact

  	if @contact.email_addresses.length > 0
  		 mail(:to => @contact.email_addresses,
  		 :cc => !Setting.cached.contact_email_cc.blank? ? Setting.cached.contact_email : '',
  		 :subject => "#{Setting.cached.group_name} Reminder: #{@signup.title} is coming up on #{@slot.date.strftime('%A')}")
	   end
  end
end
