module SignupReminderSender
	def self.send_due
		upcoming_reminders = SignupSlot.joins(:signup)
			.where('signups.send_reminder_email_days IS NOT NULL', true)
			.where('date >= ?', DateTime.now.to_date)
			.where('contact_id IS NOT NULL')
			.readonly(false)

		pending_reminders = upcoming_reminders.reject { |u|
			(u.date - u.signup.send_reminder_email_days) != DateTime.now.to_date || u.reminder_sent
		}

		settings = Setting.first
		pending_reminders.each { |r|
			UserMailer.signup_reminder_email(r).deliver
			r.reminder_sent = true
			r.save
		}
	end
end