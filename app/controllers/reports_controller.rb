class ReportsController < ApplicationController

	def email_list
		if params[:type] == 'men'
			@emails = Couple.husband_emails
		elsif params[:type] == 'women'
			@emails = Couple.wife_emails
		else 
			@emails = Couple.all_emails
		end
	end	
end
