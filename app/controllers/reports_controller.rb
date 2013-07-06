class ReportsController < ApplicationController
	layout "reports"

	def email_list
		if params[:type] == 'men'
			@emails = Contact.emails_men
			@description = 'Men Email Addresses'
		elsif params[:type] == 'women'
			@emails = Contact.emails_women
			@description = 'Women Email Addresses'
		elsif params[:type] == 'active'
			@emails = Contact.emails_all
			@description = 'Men and Women Email Addresses'
		elsif params[:type] == 'visitors'
			@emails = Contact.emails_visitors
			@description = 'Visitor Email Addresses'
		end
	end	

	def attendance_date
		if params[:type] == 'last'
			@attendance = Attendance.attendance_last
		end
	end

	def attendance_counts
	end

	def attendance_counts_data
		weeks_back = (params[:weeks_back] || 6).to_i
		include = (params[:include] || 'all')

		if include == 'visitors'
			@counts = Attendance.attendance_counts_visitors(DateTime.now - weeks_back.weeks)
		elsif include == 'members'
			@counts = Attendance.attendance_counts_members(DateTime.now - weeks_back.weeks)
		else
			@counts = Attendance.attendance_counts_all(DateTime.now - weeks_back.weeks)
		end


		respond_to do |format|
			format.json { render json: @counts.map { |count| {:date => (count.date.to_time.to_i * 1000), :count => count.count } } }
		end
	end

	def upcoming_dates
		contacts = Contact.where(:is_active => true)
		up_to_date = DateTime.now + (params[:months_up] || 6).months
		@dates = Contact.upcoming_dates(contacts, up_to_date)
	end
end
