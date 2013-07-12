module ApplicationHelper
	def nav_link(text, link)
	    recognized = Rails.application.routes.recognize_path(link)
	    if recognized[:controller] == params[:controller] # && recognized[:action] == params[:action]
	        content_tag(:li, :class => "active") do
	            link_to( text, link)
	        end
	    else
	        content_tag(:li) do
	            link_to( text, link)
	        end
	    end
	end

	def maps_link(address, city_state_zip)
		if android_agent?
			"geo:0,0?q=#{address.gsub(' ', '+')}+#{city_state_zip.gsub(' ', '+')}"
		elsif ios_agent?
			"http://maps.apple.com/?q=#{address.gsub(' ', '+')}+#{city_state_zip.gsub(' ', '+')}"
		else
			"http://maps.google.com/maps?q=#{address.gsub(' ', '+')}+#{city_state_zip.gsub(' ', '+')}"
		end
	end
end
