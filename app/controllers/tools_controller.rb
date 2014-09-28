class ToolsController < ApplicationController
	layout "tools"

	def email_list
		@description = "#{params[:type].capitalize} Email Addresses"
		@emails = Contact.email_list(params[:type].to_sym)
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

	def text
		setup_text
	end

	def text_send
		if (params[:content].blank?)
			flash.now[:error] = "Message is required."
		elsif params[:type] == "contact" && params[:contact_id].blank?
			flash.now[:error] = "Send To is required."
		elsif !params[:contact_id].nil?
			contact = Contact.find(params[:contact_id])
			if Texter.send_to_contact(contact, params[:content]) == true
				flash.now[:notice] = "Text(s) were successfully sent."
			else
				flash.now[:error] = "Text(s) could not be sent to this couple."
			end
		else
			numbers = Contact.text_number_list(params[:type].to_sym)
			if Texter.send_to_numbers(numbers, params[:content]) == true
				flash.now[:notice] = "#{numbers.length.to_s} texts were successfully sent."
			else
				flash.now[:error] = "Texts could not be sent because of an error."
			end
		end

		setup_text
		render action: "text"
	end

	def setup_text
		@description = "Send Text to #{params[:type].capitalize} Members"
		@type = params[:type]
		@contacts = nil

		if params[:type] == "contact"
			@contacts = Contact.where(:is_member => true)
		end
	end

	def email
		setup_email
	end

	def email_send
		if params[:subject].blank?
			flash.now[:error] = "Subject is required."
		elsif params[:content].blank?
			flash.now[:error] = "Message is required."
		else
		  Thread.new do
	        begin
	          email_addresses = Contact.emails_by_type(params[:type].to_sym)
	          email_addresses.each_slice(20) {|email_batch|   #batches of 20
	          	UserMailer.custom_email(email_batch, params[:subject], params[:content]).deliver
	          }
	        rescue => ex
	          logger.error ex.message
	        ensure
	          ActiveRecord::Base.connection_pool.release_connection
	        end
	      end
  		
  		  flash.now[:notice] = "Emails were successfully sent."
		end

		setup_email
		render action: "email"
	end

	def setup_email
		@description = "Send Email to #{params[:type].capitalize}"
		@type = params[:type]
	end
end
