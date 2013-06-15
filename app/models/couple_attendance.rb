class CoupleAttendance
	attr_accessor :couple_id, :name, :date, :husband_present, :wife_present

 	def initialize(attributes = {})  
   		attributes.each do |name, value|  
      		send("#{name}=", value)  
    	end  
  	end
end