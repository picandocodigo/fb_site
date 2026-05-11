require 'net/http'
require 'rss'
require 'simple-rss'
require 'uri'

module Blog
  def self.info(url)
    xml = Net::HTTP.get(URI(url)).force_encoding('utf-8')
    SimpleRSS.parse(xml)
  rescue ArgumentError => e
    # Print error and try with RSS
    puts e
    RSS::Parser.parse(url).items
  end
end
