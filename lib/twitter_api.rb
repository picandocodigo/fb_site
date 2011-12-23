require 'httparty'
require 'twitter_user'
require 'error_display'

module TwitterApi

  # @param screen_name [String]
  def self.get_user screen_name
    json = HTTParty.get 'http://api.twitter.com/1/users/show.json?screen_name=' + screen_name
    raise ErrorDisplay.new json['error'], 400 if json['error']
    TwitterUser.new_from_json json
  end

  # @param screen_name [String]
  def self.get_user_tweets screen_name
    ret = HTTParty.get 'https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=' + screen_name + '&count=20'
    @tweets = process_tweets ret.parsed_response
  end
  
  def self.process_tweets tweets
    tweets.each do |tweet|
      date = DateTime.strptime(tweet['created_at'], '%a %b %d %H:%M:%S')
      #TODO: Get date format from a yaml file 
      tweet['created_at'] = date.strftime("%d/%m/%Y %H:%M:%S")
    end
    tweets
  end
  
end