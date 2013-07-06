module GoogleCalendarSynchronizer
	def self.sync_contacts(username, password, contacts)
		service = GCal4Ruby::Service.new
		if service.authenticate(username, password)
			contacts_count = contacts.length
			existing_events = GCal4Ruby::Event.find(service, "[auto:", { 'max-results' => (contacts_count * 3), 'start-min' => (DateTime.now - 1.day).rfc3339 })
			upcoming_events = Contact.upcoming_dates(contacts, DateTime.now + 3.months)
			upcoming_events.each do |e|
				sync_event(service, e, existing_events)
			end
		end

		return true
	end

	def self.sync_event(service, event, existing_events)
		target_event = existing_events.select { |e| e.content.include? ("contact_id=#{event[:contact_id]}:#{event[:type]}") }.first
		if target_event.nil?
			puts "Adding New Event: #{event[:description]}, #{event[:date].to_time} (id:#{event[:contact_id]})"
			target_event = GCal4Ruby::Event.new(service)
			target_event.calendar = service.calendars[0]
			target_event.content = "[auto:contact_id=#{event[:contact_id]}:#{event[:type]}]"
			target_event.all_day = true
		else
			puts "Updating Event: #{event[:description]}, #{event[:date].to_time} (id:#{event[:contact_id]})"
		end

		target_event.title = event[:description]
		target_event.start_time = event[:date].to_time
		target_event.end_time = event[:date].to_time
		target_event.save
	end

	def self.delete_auto_events(username, password, max_count)
		service = GCal4Ruby::Service.new
		if service.authenticate(username, password)
			auto_events = GCal4Ruby::Event.find(service, "[auto:", { 'max-results' => max_count, 'start-min' => DateTime.now.rfc3339 })
			auto_events.each do |e|
				e.delete
			end
		end
	end
end