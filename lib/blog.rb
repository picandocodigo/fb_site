require 'simple-rss'
require 'uri'
require 'net/http'

module Blog
  def self.info(url)
    xml = Net::HTTP.get(URI(url)).force_encoding('UTF-8')
    SimpleRSS.parse(xml)
  end
end
