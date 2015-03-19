require 'google/api_client'

module GoogleCalendarSynchronizer
	def self.sync_contacts(refresh_token, contacts)
		client_secrets = Google::APIClient::ClientSecrets.load
		auth_client = client_secrets.to_authorization
		auth_client.refresh_token = refresh_token
		auth_client.fetch_access_token!

		api_client = Google::APIClient.new
		cal = api_client.discovered_api('calendar', 'v3')

        start_min = (DateTime.now - 1).utc.xmlschema.gsub("+", "-")  
		contacts_count = contacts.length
			
		existing_events = api_client.execute(:api_method => cal.events.list, :authorization => auth_client,
			:parameters => {'maxResults' => (contacts_count * 3), 'timeMin' => start_min, 'q' => '[auto:', 'calendarId' => 'primary'})

		upcoming_events = Contact.upcoming_dates(contacts, DateTime.now + 3.months)
		upcoming_events.each do |e|
			sync_event(api_client, auth_client, cal, e, existing_events.data.items)
		end
	
		return true
	end

	def self.sync_event(api_client, auth_client, cal, event, existing_events)
		target_event = existing_events.select { |e| e.description.include? ("contact_id=#{event[:contact_id]}:#{event[:type]}") }.first
		if target_event.nil?
			puts "Adding New Event: #{event[:description]}, #{event[:date].to_time} (id:#{event[:contact_id]})"
			
			target_event = cal.events.insert.request_schema.new
			target_event.description = "[auto:contact_id=#{event[:contact_id]}:#{event[:type]}]"
			target_event.summary = event[:description]
			target_event.start = { 'date' => event[:date].to_date } 
			target_event.end = { 'date' => event[:date].to_date } 

			result = api_client.execute(:api_method => cal.events.insert, 
				:parameters => { 'calendarId' => 'primary'}, 
				:headers => {'Content-Type' => 'application/json'},
				:body_object => target_event,
				:authorization => auth_client)
		else
			puts "Updating Event: #{event[:description]}, #{event[:date].to_time} (id:#{event[:contact_id]})"
			
			target_event.summary = event[:description]
			target_event.start = { 'date' => event[:date].to_date } 
			target_event.end = { 'date' => event[:date].to_date } 

			result = api_client.execute(:api_method => cal.events.update, 
				:parameters => { 'calendarId' => 'primary', 'eventId' => target_event.id}, 
				:headers => {'Content-Type' => 'application/json'},
				:body_object => target_event,
				:authorization => auth_client)
		end
	end

	def self.delete_auto_events(refresh_token, max_count)
		client_secrets = Google::APIClient::ClientSecrets.load
		auth_client = client_secrets.to_authorization
		auth_client.update!(
		  :scope => 'https://www.googleapis.com/auth/calendar',
		  :access_type => "online",
		  :approval_prompt =>'force',
		  :redirect_uri => 'http://www.hfbctheoaks.com'
		)

		auth_client.refresh_token = refresh_token
		auth_client.fetch_access_token!
		api_client = Google::APIClient.new
		cal = api_client.discovered_api('calendar', 'v3')

		existing_events = api_client.execute(:api_method => cal.events.list, :authorization => auth_client,
			:parameters => {'maxResults' => max_count, 'q' => '[auto:', 'calendarId' => 'primary'})

		existing_events.data.items.each do |e|
			api_client.execute(:api_method => cal.events.delete, :authorization => auth_client,
            	:parameters => {'calendarId' => 'primary', 'eventId' => e.id})
		end		
	end
end
