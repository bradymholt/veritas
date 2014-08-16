module Texter
	def self.send(numbers, message)
	      begin
          phone_carriers = PhoneCarrierLookup.where(phone_number: numbers)
          carriers_by_number = Hash[phone_carriers.collect { |c| [c.phone_number, c]}]
          lookup_api_url = VeritasWeb::Application.config.carrier_lookup_api_url + "key=" + Setting.cached.carrier_lookup_api_key + "&number="
          numbers.each { |n|
          	if carriers_by_number[n].nil?
              begin
            		new_phone_carrier = PhoneCarrierLookup.new
            		new_phone_carrier.phone_number = n

            		response_body = open(lookup_api_url + n).read.downcase
            		response_parsed = JSON.parse(response_body, :symbolize_names => true)
            		response = response_parsed[:response]

            		new_phone_carrier.carrier = response[:carrier]
            		new_phone_carrier.type = response[:carrier_type]
            		new_phone_carrier.save

            		carriers_by_number[n] = new_phone_carrier
              rescue => ex
                Rails.logger.error ex.message
              end
          	end

            if !carriers_by_number[n].nil?
              sms_gateway_email = ""
              
              case carriers_by_number[n].carrier.downcase
                  when /verizon/
                    sms_gateway_email = "#{n}@vtext.com"
                  when /sprint/
                    sms_gateway_email = "#{n}@messaging.sprintpcs.com"
                  when /tmobile/
                    sms_gateway_email = "#{n}@vtext.com"
                  when /at&t/
                    sms_gateway_email = "#{n}@txt.att.net"
                  when /nextel/
                    sms_gateway_email = "#{n}@messaging.nextel.com"
                  when /cricket/
                    sms_gateway_email = "#{n}@sms.mycricket.com"
                  when /aio/
                    sms_gateway_email = "#{n}@mms.aiowireless.net"
                  else 
                    sms_gateway_email = nil
              end

              if !sms_gateway_email.nil?
            	 #UserMailer.text_message(sms_gateway_email, message).deliver
              end
            end
        }

        rescue => ex
          Rails.logger.error ex.message
        ensure
          ActiveRecord::Base.connection_pool.release_connection
        end
	end
end