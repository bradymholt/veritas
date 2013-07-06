namespace :db do
	desc "Erase and fill database with test records"
	task :populate => :environment do
		Contact.delete_all
		Contact.create(
			[
				{   :last_name => 'Holt', 
					:first_name => 'Brady', 
					:spouse_name => 'Katie',
					:address => '1355 Del Norte',
					:city_state_zip => 'Houston, TX 77018',
					:home_phone => '',
					:anniversary => '10/1/2005',
					:email => 'brady.holt@gmail.com',
					:spouse_email => 'katini@gmail.com',
					:spouse_phone => '7136149522',
					:phone => '7134949132',
					:spouse_birthday => '11/16/1980',
					:birthday => '3/13/1980',
					:is_member => true,
					:is_active => true
				},
				{   :last_name => 'Simon', 
					:first_name => 'Eldad', 
					:spouse_name => 'Raluca',
					:address => '1200 Willow Dr',
					:city_state_zip => 'Houston, TX 77253',
					:home_phone => '',
					:anniversary => '10/1/2005',
					:email => 'eldad@gmail.com',
					:spouse_email => 'raluca@gmail.com',
					:spouse_phone => '5555555555',
					:phone => '5555555555',
					:spouse_birthday => '4/1/1980',
					:birthday => '5/5/1980',
					:is_member => true,
					:is_active => true
				}
			]
		)

		Podcast.delete_all
		Podcast.create(
			[
				{ :date => '3/13/1980', :title => 'Salvation', :speaker => 'Brady Holt'}
			]
		)

		ContactQueueItem.delete_all
		c = Contact.first
		ContactQueueItem.create(
			[
				{ :contact_id => c.id, :reason => 'Absent for 2 weeks' }
			]
		)
	end
end