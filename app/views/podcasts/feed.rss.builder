xml.instruct! :xml, :version => "1.0" 
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", :version => "2.0" do
  xml.channel do
    xml.title Setting.cached.group_name
    xml.link "#{request.protocol + request.host_with_port}/"
    xml.language "en-us"
    xml.copyright "#{DateTime.now.year} - #{Setting.cached.group_name}"
    xml.description Setting.cached.group_description
    xml.itunes :subtitle, Setting.cached.group_description
    xml.itunes :author, Setting.cached.group_name
    xml.itunes :summary, Setting.cached.group_description
    xml.itunes :category, "Religion & Spirituality"
    xml.itunes :category, "Christianity"
	  xml.itunes :owner do |t|
   		t.itunes :name, Setting.cached.group_name
   		t.itunes :email, Setting.cached.contact_email
	end

	xml.itunes :image, :href => "#{Setting.cached.app_icon_url}" 

    for post in @podcasts
      xml.item do
        xml.title post.description
        xml.itunes :author, post.speaker
        xml.itunes :summary, post.speaker
        xml.description post.title
        xml.pubDate post.created_at.to_formatted_s(:rfc822)  
        xml.enclosure :url => post.audio_url, :type => "audio/mpeg"
        xml.link post.audio_url
        xml.guid "#{Setting.cached.group_name.split[0].downcase}_lesson_#{post.id}"
      end
    end
  end
end