namespace :app do
	desc "Weekly App bots"
	task :weekly_bots => [:environment, :contact_bot, :contact_queue_bot, :calendar_bot]  do
	end

	desc "Daily App bots"
	task :daily_bots => [:environment, :signup_reminder_bot] do
	end

	desc "Signup reminder bot"
	task :signup_reminder_bot => :environment do
		puts "[signup_reminder_bot]"
		SignupReminderSender.send_due
	end

	desc "Contact bot"
	task :contact_bot => :environment do
		puts "[roster_bot]"
		settings = Setting.first
		if !settings.contacts_inactivate_after_no_attendance_weeks.nil?
			puts "Inactivating contacts without atendance in #{settings.contacts_inactivate_after_no_attendance_weeks} weeks."
			last_attendance_before = DateTime.now - (settings.contacts_inactivate_after_no_attendance_weeks).weeks
			
			contact_id_inactive = Attendance.select('contact_id')
				.includes(:contact)
				.where('contacts.is_active = ?', true)
				.group('contact_id')
				.having('max(date) < ?', last_attendance_before)
				.map(&:contact_id)

			Contact.update_all({:is_active => false}, ['id IN (?)', contact_id_inactive ])
			puts "#{contact_id_inactive.length} contacts inactivated."
		end

	end

	desc "Contact queue bot"
	task :contact_queue_bot => :environment do
		puts "[contact_queue_bot]"
		ContactQueueEngine.queue_all
	end

	desc "Calendar bot"
	task :calendar_bot => :environment do
		puts "[calendar_bot]"
		settings = Setting.first
		if settings.google_calendar_enabled?
			sync_contacts = Contact.where(:is_member => true, :is_active => true)
			GoogleCalendarSynchronizer.sync_contacts(settings.google_calendar_refresh_token, sync_contacts)
		else
			"No calendar sync in configured."
		end
	end
end