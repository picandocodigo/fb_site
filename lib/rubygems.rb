require 'net/http'
require 'open-uri'
require 'json'

module RubyGems
  def self.info(user)
    JSON.parse(Net::HTTP.get('rubygems.org',"/api/v1/owners/#{user}/gems.json"))
  end

end
