# Get developer's Plugins
module WordPressPlugins
  require 'nokogiri'
  require 'open-uri'

  # Scraper for the WordPress.org's profile page. Gets a user's
  # plugins, url, name and downloads.
  def self.plugins(user)
    plugins = []
    url = "https://profiles.wordpress.org/#{user}"
    doc = Nokogiri::HTML(open(url))
    doc.css('div#content-plugins ul li').each do |p|
      plugins.push plugin(p)
    end

    plugins
  end

  # rubocop:disable Metrics/AbcSize
  # This is parsing html, so it's probaby as good as it gets:
  def self.plugin(p)
    {
      url:  p.children[3].children[1].children[1].attributes['href'].value,
      name: p.children[3].children[1].children[1].text,
      downloads: p.children[3].children[3].text

    }
  end
end
