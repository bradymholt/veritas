class AdminMailer < ActionMailer::Base
	default :from =>  "#{Setting.cached.group_name} <#{Setting.cached.contact_email}>"

	def contact_queue_updated_email(queued_count)
		@count = queued_count
	
		mail(:to => Setting.cached.contact_queue_notify_email, 
			 :cc => !Setting.cached.contact_email_cc.blank? ? Setting.cached.contact_email : '',
			 :subject => "#{Setting.cached.group_name} - Contact Queue Updated")
	end
end
