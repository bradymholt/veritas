class ReportsController < ApplicationController

	def email_list
		if params[:type] == 'men'
			@emails = Family.husband_emails
		elsif params[:type] == 'women'
			@emails = Family.wife_emails
		else 
			@emails = Family.all_emails
		end
	end	
end
