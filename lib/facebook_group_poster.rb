module FacebookGroupPoster
	def self.send_pending(settings)
		podcasts_to_post = Podcast.where(:is_facebook_posted => false)
			   .where('date >= ?', DateTime.now - 1.week) #1 week ago or sooner
			   .where('speaker != ?', 'TBD')

	    podcasts_to_post.each do |podcast|
	    	graph = Koala::Facebook::API.new(settings.facebook_access_token)
	    	graph.put_object(settings.facebook_group_id, "feed", { :name => "#{podcast.title} - #{podcast.speaker}", :link => podcast.audio_url, :message => "New Podcast is Available!" })
	    	podcast.is_facebook_posted = true
	    	podcast.save
	    end

	    signups_to_post = Signup.where(:is_facebook_posted => false)
	    	.where(:visible_admin_only => false)
	    	.where('created_at >= ?', DateTime.now - 1.week) #1 week ago or sooner

	    signups_to_post.each do |signup|
	    	graph = Koala::Facebook::API.new(settings.facebook_access_token)
	    	graph.put_object(settings.facebook_group_id, "feed", { :name => "#{signup.title}", :link => "http://" + settings.host_name, :message => "New Signup is Available! - #{signup.title}" })
	    	signup.is_facebook_posted = true
	    	signup.save
	    end
	end
end