module SignupReminderSender
	def self.send_due
		upcoming_reminders = SignupSlot.joins(:signup)
			.where('signups.send_reminder_days IS NOT NULL', true)
			.where('date >= ?', DateTime.now.to_date)
			.where('contact_id IS NOT NULL')
			.readonly(false)

		pending_reminders = upcoming_reminders.reject { |u|
			(u.date - u.signup.send_reminder_days) != DateTime.now.to_date || u.reminder_sent
		}

		pending_reminders.each { |signup_slot|
			contact = signup_slot.contact
			signup = signup_slot.signup

			UserMailer.signup_reminder_email(contact, signup_slot, signup).deliver

			r.reminder_sent = true
			r.save
		}
	end
end