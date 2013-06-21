namespace :app do
	desc "App bots"
	task :bots => :environment do
		Rake::Task["app:roster_bot"].execute
		Rake::Task["app:contact_queue_bot"].execute
		Rake::Task["app:calendar_bot"].execute
	end

	desc "Roster bot"
	task :roster_bot => :environment do
		puts "[roster_bot]"
		puts "Inactivating families without atendance in 6 months..."
		family_id_last_attendance_six_months_ago = Attendance.select('family_id').includes(:family).where('families.is_active = ?', true).group('family_id').having('max(date) <= ?', DateTime.now.to_date - 6.months).map(&:family_id)
		Family.update_all({:is_active => false}, ['id IN (?)', family_id_last_attendance_six_months_ago ])
		puts "#{family_id_last_attendance_six_months_ago.length} families inactivated."

	end

	desc "Contact queue bot"
	task :contact_queue_bot => :environment do
		puts "[contact_queue_bot]"

		ContactQueueEngine.queue_new_visitors
		ContactQueueEngine.queue_absent_members
	end

	desc "Calendar bot"
	task :calendar_bot => :environment do
		puts "[calendar_bot]"
		settings = Setting.first
		if !settings.google_calendar_username.blank? && !settings.google_calendar_password.blank?
			sync_families = Family.where(:is_member => true, :is_active => true)
			GoogleCalendarSynchronizer.sync_families(settings.google_calendar_username, settings.google_calendar_password, sync_families)
		else
			"No calendar sync in configured."
		end
	end
end