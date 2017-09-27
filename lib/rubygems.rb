require 'open-uri'
require 'json'

# Get a user's gems
module RubyGems
  def self.info(user)
    JSON.parse(
      URI.parse("https://rubygems.org/api/v1/owners/#{user}/gems.json").read
    ).sort_by { |gem| gem['downloads'].to_i }.reverse
  end
end
