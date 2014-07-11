require 'net/http'
require 'open-uri'
require 'json'

module RubyGems
  def self.info
    JSON.parse(Net::HTTP.get('rubygems.org', '/api/v1/owners/picandocodigo/gems.json'))
  end

  def self.env
    @env ||= File.expand_path(File.dirname(__FILE__)) + "/.env"
  end
end
