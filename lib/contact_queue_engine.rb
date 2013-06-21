module ContactQueueEngine
	def self.queue_new_visitors
		puts "Queuing new visitors from last Sunday..."

		count = 0
		last_sunday = (DateTime.now - DateTime.now.wday).to_date
		last_sunday_family_id_present = Attendance.where(:date => last_sunday).map(&:family_id)
		last_sunday_visitors = Family.where(:is_member => false, :id => last_sunday_family_id_present)
		last_sunday_visitors.each do |visitor|
			if !ContactQueueItem.exists?(:family_id => visitor.id, :is_completed => false)
				puts "Adding Visitor: " + visitor.full_name
				cq = ContactQueueItem.new
				cq.family_id = visitor.id
				cq.reason = 'First Time Visitor'

				visit_count = Attendance.where(:family_id => visitor.id).count
				if visit_count > 1
					cq.reason = cq.reason + ' (' + visit_count.to_s + ')'
				end

				cq.save
				count+=1
			end
		end

		puts "Done queuing new visitors.  #{count} visitors added."
	end

	def self.queue_absent_members
		puts "Queuing members absent 3 weeks..."
	
		count = 0
		last_sunday = (DateTime.now - DateTime.now.wday).to_date
		last_three_weeks_family_id_present = Attendance.where('date >= ?', last_sunday - 2.weeks).map(&:family_id)
		members_absent_three_weeks = Family.where(:is_member => true, :is_active => true).where('id NOT IN (?)', last_three_weeks_family_id_present)
		
		members_absent_three_weeks.each do |absent_member|
			if !ContactQueueItem.exists?(:family_id => absent_member.id, :is_completed => false)
				puts "Adding Family: " + absent_member.full_name
				cq = ContactQueueItem.new
				cq.family_id = absent_member.id
				cq.reason = 'Member Absent 3 Weeks'
				cq.save
				count+=1
			end
		end

		puts "Done queuing absent members.  #{count} families queued."
	end
end