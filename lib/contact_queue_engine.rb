module ContactQueueEngine
	def self.queue_all
		settings = Setting.first
		total_count = 0

		if !settings.contact_queue_visitors_present_weeks.nil?
			total_count += ContactQueueEngine.queue_visitors(settings.contact_queue_visitors_present_weeks)
		end

		if !settings.contact_queue_members_absent_weeks.nil?
			total_count += ContactQueueEngine.queue_absent_members(settings.contact_queue_members_absent_weeks)
		end

		if total_count > 0 && !settings.contact_queue_notify_email.blank?
			ContactQueueMailer.new_queued(settings.contact_queue_notify_email, total_count, settings.host_name).deliver
		end
	end

	def self.queue_visitors(max_queue_count)
		puts "Queuing visitors..."

		count = 0
		last_sunday = (DateTime.now - DateTime.now.wday).to_date
		last_sunday_family_id_present = Attendance.where(:date => last_sunday).map(&:family_id)
		last_sunday_visitors = Family.where(:is_member => false, :is_active => true, :id => last_sunday_family_id_present)
		visitors_to_queue = last_sunday_visitors.reject { |q| q.count_attendance > max_queue_count}
		visitors_to_queue.each do |visitor|
			if !ContactQueueItem.exists?(:family_id => visitor.id, :is_completed => false)
				puts "Adding Visitor: " + visitor.full_name
				cq = ContactQueueItem.new
				cq.family_id = visitor.id

				if (visitor.count_attendance == 0)
					cq.reason = "First Time Visitor"
				else
					cq.reason = "Returning Visitor (#{visitor.count_attendance})"
				end

				cq.save
				count+=1
			end
		end

		puts "Done queuing visitors.  #{count} visitors added."
		count
	end

	def self.queue_absent_members(weeks_absent)
		puts "Queuing absent members..."
	
		count = 0
		last_sunday = (DateTime.now - DateTime.now.wday).to_date
		family_id_exclude = Attendance.where('date >= ?', last_sunday - (weeks_absent - 1).weeks).map(&:family_id)
		members_to_queue = Family.where(:is_member => true, :is_active => true).where('id NOT IN (?)', family_id_exclude)
		
		members_to_queue.each do |absent_member|
			if !ContactQueueItem.exists?(:family_id => absent_member.id, :is_completed => false)
				puts "Adding Family: " + absent_member.full_name
				cq = ContactQueueItem.new
				cq.family_id = absent_member.id
				cq.reason = "Member Absent #{weeks_absent} Weeks"
				cq.save
				count+=1
			end
		end

		puts "Done queuing absent members.  #{count} families queued."
		count
	end
end