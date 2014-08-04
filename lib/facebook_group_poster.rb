module FacebookGroupPoster
	def self.post_podcast(id)
		settings = Setting.first
		podcast = Podcast.find(id)
		if !podcast.is_facebook_posted? && !settings.facebook_access_token.blank? && !settings.facebook_group_id.blank?
	    	graph = Koala::Facebook::API.new(settings.facebook_access_token)
	    	podcast_date = podcast.date.strftime('%m/%d')
	    	graph.put_object(settings.facebook_group_id, "feed", { :name => "#{podcast.title} - #{podcast.speaker}, #{podcast_date}", :link => podcast.audio_url, :message => "New Podcast for #{podcast_date} is Available!" })
	    	podcast.is_facebook_posted = true
	    	podcast.save
	    end
	end

	def self.post_signup(id)
		settings = Setting.first
		signup = Signup.find(id)
	    if !signup.visible_admin_only
	    	graph = Koala::Facebook::API.new(settings.facebook_access_token)
	    	graph.put_object(settings.facebook_group_id, "feed", { :name => "#{signup.title}", :link => "http://" + settings.host_name, :message => "Please Sign Up for: #{signup.title} (password: '#{settings.user_password}')" })
	    end
	end
end