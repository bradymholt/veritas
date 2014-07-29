module FacebookGroupPoster
	def self.post_podcasts(access_token, group_id)
		podcasts_to_post = Podcast.where(:is_facebook_posted => false)
			   .where('date >= ?', DateTime.now - 1.week) #1 week ago or sooner
			   .where('speaker != ?', 'TBD')

	    podcasts_to_post.each do |podcast|
	    	graph = Koala::Facebook::API.new(access_token)
	    	podcast_date = podcast.date.strftime('%m/%d')
	    	graph.put_object(group_id, "feed", { :name => "#{podcast.title} - #{podcast.speaker}, #{podcast_date}", :link => podcast.audio_url, :message => "New Podcast is Available!" })
	    	podcast.is_facebook_posted = true
	    	podcast.save
	    end
	end

	def self.post_signup(id)
		settings = settings = Setting.first
		signup = Signup.find(id)
	    if !signup.visible_admin_only
	    	graph = Koala::Facebook::API.new(settings.facebook_access_token)
	    	graph.put_object(settings.facebook_group_id, "feed", { :name => "#{signup.title}", :link => "http://" + settings.host_name, :message => "Please Sign Up for: #{signup.title} (password: '#{settings.user_password}')" })
	    end
	end
end