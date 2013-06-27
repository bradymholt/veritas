class SignupMailer < ActionMailer::Base
  default :from =>  "#{Setting.cached.group_name} <#{Setting.cached.contact_email}>"

  def reminder(signup_slot, host_name)
  	@slot = signup_slot
  	@signup = signup_slot.signup
  	@family = signup_slot.family
  	@host = host_name

  	if @family.email_addresses.length > 0
		 mail(:to => @family.email_addresses, :subject => "#{@signup.title} is coming up on #{@slot.date.strftime('%A')}")
	end
  end
end
