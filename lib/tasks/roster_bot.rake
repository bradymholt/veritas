namespace :app do
	desc "Roster bot"
	task :roster_bot => :environment do

		couple_id_last_attendance_six_months_ago = Attendance.select('couple_id').includes(:couple).where('couples.is_active = ?', true).group('couple_id').having('max(date) <= ?', DateTime.now.to_date - 6.months).map(&:couple_id)

		Couple.update_all({:is_active => false}, ['id IN (?)', couple_id_last_attendance_six_months_ago ])

	end
end