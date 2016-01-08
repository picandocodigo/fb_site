require 'open-uri'
require 'json'

module RubyGems
  def self.info(user)
    JSON.parse(
      URI.parse("https://rubygems.org/api/v1/owners/#{user}/gems.json").read
    )
  end
end
