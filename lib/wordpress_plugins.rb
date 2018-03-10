# Get developer's Plugins
module WordPressPlugins
  require 'nokogiri'
  require 'open-uri'
  API_URL = 'https://api.wordpress.org/plugins/info/1.0/'.freeze

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
  def self.plugin(plugin)
    installs = plugin.children[3].children[3].text
    url = plugin.children[3].children[1].children[1].attributes['href'].value
    slug = url.match(%r{.*\/([a-z-]+)\/$}).captures[0]

    result = JSON.parse(
      open("#{API_URL}#{slug}.json").read
    ).merge('installs' => installs)
    result
  end
end
