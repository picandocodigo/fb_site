require 'rss'

module Blog
  def self.info(url)
    RSS::Parser.parse(url).items
  end
end
