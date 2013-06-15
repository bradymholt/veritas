namespace :app do
	desc "Generate contact queue items"
	task :contact_queue_bot => :environment do
		puts "Contact Queue -- Processing Visitors from last Sunday..."
		last_sunday = (DateTime.now - DateTime.now.wday).to_date

		#visitors
		last_sunday_couple_id_present = Attendance.where(:date => last_sunday).map(&:couple_id)
		last_sunday_visitors = Couple.where(:is_member => false, :id => last_sunday_couple_id_present)
		puts "Last Sunday Visitor Count: " + last_sunday_visitors.count.to_s
		last_sunday_visitors.each do |visitor|
			if !ContactQueueItem.exists?(:couple_id => visitor.id, :is_completed => false)
				puts "Adding Visitor: " + visitor.full_name
				cq = ContactQueueItem.new
				cq.couple_id = visitor.id
				cq.reason = 'First Time Visitor'

				visit_count = Attendance.where(:couple_id => visitor.id).count
				if visit_count > 1
					cq.reason = cq.reason + ' (' + visit_count.to_s + ')'
				end

				cq.save
			end
		end

		#members absent 3 weeks
		last_three_weeks_couple_id_present = Attendance.where('date >= ?', last_sunday - 2.weeks).map(&:couple_id)
		members_absent_three_weeks = Couple.where(:is_member => true).where('id NOT IN (?)', last_three_weeks_couple_id_present)
		members_absent_three_weeks.each do |absent_member|
			if !ContactQueueItem.exists?(:couple_id => absent_member.id, :is_completed => false)
				puts "Adding Member: " + absent_member.full_name
				cq = ContactQueueItem.new
				cq.couple_id = absent_member.id
				cq.reason = 'Member Absent 3 Weeks'
				cq.save
			end
		end
	end
end