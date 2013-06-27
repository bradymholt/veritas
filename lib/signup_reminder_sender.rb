module SignupReminderSender
	def self.send_due
		upcoming_reminders = SignupSlot.joins(:signup)
			.where('signups.send_reminder_email = ?', true)
			.where('date >= ?', DateTime.now.to_date)
			.where('family_id IS NOT NULL')

		pending_reminders = upcoming_reminders.reject { |u|
			(u.date - u.signup.send_reminder_email_days) != DateTime.now.to_date
		}

		settings = Setting.first
		pending_reminders.each { |r|
			SignupMailer.reminder(r, settings.host_name).deliver
		}
	end
end