class ContactQueueMailer < ActionMailer::Base
	default :from =>  "#{Setting.cached.group_name} <#{Setting.cached.contact_email}>"

	def new_queued(notify_email, queued_count, host_name)
		@count = queued_count
		@host = host_name
	
		mail(:to => notify_email, :subject => "Contact Queue Updated")
	end
end
