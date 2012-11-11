class TwitterUser
  attr_accessor :name, :screen_name, :profile_image_url, :description, :location, :friends_count, :followers_count

  def self.new_from_json json
    t = self.new
    t.name = json['name']
    t.screen_name = json['screen_name']
    t.profile_image_url = json['profile_image_url']
    t.description = json['description']
    t.location = json['location']
    t.friends_count = json['friends_count']
    t.followers_count = json['followers_count']
    t
  end

  def to_s
    "#{@name} #{@screen_name} #{@profile_image_url} #{@description} #{@location} #{@friends_count} #{@followers_count}"
  end

end