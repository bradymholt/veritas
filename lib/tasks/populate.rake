namespace :db do
	desc "Erase and fill database with test records"
	task :populate => :environment do
		Couple.delete_all
		Couple.create(
			[
				{   :last_name => 'Holt', 
					:husband_name => 'Brady', 
					:wife_name => 'Katie',
					:address => '1355 Del Norte',
					:city_state_zip => 'Houston, TX 77018',
					:home_phone => '',
					:anniversary => '10/1/2005',
					:husband_email => 'brady.holt@gmail.com',
					:wife_email => 'katini@gmail.com',
					:wife_phone => '7136149522',
					:husband_phone => '7134949132',
					:wife_birthday => '11/16/1980',
					:husband_birthday => '3/13/1980',
					:is_member => true,
					:is_active => true
				},
				{   :last_name => 'Simon', 
					:husband_name => 'Eldad', 
					:wife_name => 'Raluca',
					:address => '1200 Willow Dr',
					:city_state_zip => 'Houston, TX 77253',
					:home_phone => '',
					:anniversary => '10/1/2005',
					:husband_email => 'eldad@gmail.com',
					:wife_email => 'raluca@gmail.com',
					:wife_phone => '5555555555',
					:husband_phone => '5555555555',
					:wife_birthday => '4/1/1980',
					:husband_birthday => '5/5/1980',
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
		c = Couple.first
		ContactQueueItem.create(
			[
				{ :couple_id => c.id, :reason => 'Absent for 2 weeks' }
			]
		)
	end
end