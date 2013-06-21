module GoogleCalendarSynchronizer
	def self.sync_families(username, password, families)
		service = GCal4Ruby::Service.new
		if service.authenticate(username, password)
			families_count = families.length
			auto_events = GCal4Ruby::Event.find(service, "[auto:", { 'max-results' => (families_count * 3), 'start-min' => DateTime.now.rfc3339 })
			families.each do |f|
				puts "Syncing Family: #{f.full_name} (id:#{f.id})"
				auto_family_events = auto_events.select { |e| e.content.include? ("family_id=" + f.id.to_s) }
				sync_family_date(service, auto_family_events, f, 'anniversary', f.anniversary)
				sync_family_date(service, auto_family_events, f, 'husband_birthday', f.husband_birthday)
				sync_family_date(service, auto_family_events, f, 'wife_birthday', f.wife_birthday)
				puts "Done syncing family."
			end
		end

		return true
	end

	def self.sync_family_date(service, auto_family_events, family, date_identifier, date)
		if !date.nil?
			event_date = Time.mktime(DateTime.now.year, date.month, date.day)
			if event_date < DateTime.now
				event_date = event_date + 1.year
			end

			if (event_date <= DateTime.now + 3.months) #in next 3 months
				event = auto_family_events.select { |e| e.content.include? (":#{date_identifier}") }.first
				if event.nil?
					puts "Adding New #{date_identifier} event: #{family.full_name} (id:#{family.id})"
					event = GCal4Ruby::Event.new(service)
					event.calendar = service.calendars[0]
					event.content = "[auto:family_id=#{family.id}:#{date_identifier}]"
					event.all_day = true
				else
					puts "Updating #{date_identifier} event: #{family.full_name} (id:#{family.id})"
				end

				if date_identifier == "anniversary"
					event.title = "Anniversary - #{family.last_name}"
				elsif date_identifier == "husband_birthday"
					event.title = "Birthday - #{family.husband_name} #{family.last_name}"
				elsif date_identifier == "wife_birthday"
					event.title = "Birthday - #{family.wife_name} #{family.last_name}"
				end

				event.start_time = event_date
				event.end_time = event_date
				event.save
			end
		end
	end
end