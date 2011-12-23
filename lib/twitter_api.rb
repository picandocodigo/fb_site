require 'httparty'
require 'twitter_user'
require 'error_display'
require 'rails'

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
      #"user_mentions"=>[{"id_str"=>"16634447", "name"=>"xombra", "indices"=>[3, 10], "screen_name"=>"xombra", "id"=>16634447},
      # ], "user_mentions"=>[{"id_str"=>"18435696", "name"=>"Daniel M. Maldonado", "indices"=>[3, 13], "screen_name"=>"elcodigok", "id"=>18435696}]},
      text = tweet['text'] 
      if (!tweet['entities']['user_mentions'].nil?)
        tweet['entities']['user_mentions'].each do |mention|
          link = "<a href='http://twitter.com/#{mention['screen_name']}'>@#{mention['screen_name']}</a>"
          #tweet['text'] = text.gsub("@#{mention['screen_name']}", link)
          #string = tweet['text'][mention['indices'][0], mention['indices'][1]]
          string = "@#{mention['screen_name']}"
          #tweet['text'].gsub!(string, link)
          set_links tweet['text'], string, link
        end
      end
      #"hashtags"=>[{"indices"=>[15, 20], "text"=>"Ruby"}, {"indices"=>[31, 39], "text"=>"cerveza"}],
      if (!tweet['entities']['hashtags'].nil?)
        tweet['entities']['hashtags'].each do |tag|
          string = "\##{tag["text"]}"
          link = "<a href='http://twitter.com/#!/search?q=%23#{tag['text']}'>\##{tag['text']}</a>"
          set_links tweet['text'], string, link
        end
      end
       
      #"urls"=>[{"url"=>"http://t.co/wyG7MRgj", "indices"=>[88, 108], "expanded_url"=>"http://xkcd.com/323/", "display_url"=>"xkcd.com/323/"}],
      if (!tweet['entities']['urls'].nil?)
        tweet['entities']['urls'].each do |url|
          string = url['url']
          link = "<a href='#{url['expanded_url']}'>#{url['url']}</a>"
          set_links tweet['text'], string, link
        end
      end 
    end
    tweets
  end
  
  def self.set_links text, string, link
    text.gsub!(string, link)
  end
  
end