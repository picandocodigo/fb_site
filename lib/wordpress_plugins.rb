module WordPressPlugins
  require 'nokogiri'
  require 'open-uri'

  # Scraper for the WordPress.org's profile page. Gets a user's
  # plugins, url, name and downloads.
  def self.get_plugins(user)
    plugins = []
    url = "https://profiles.wordpress.org/#{user}"
    doc = Nokogiri::HTML(open(url))
    doc.css('div#content-plugins ul li').each do |p|
      plugin = {
        url: p.children[4].children[1].children[1].attributes['href'].value,
        name: p.children[4].children[1].children[1].children[0].text,
        downloads: p.children[4].children[3].text
      }
      plugins.push plugin
    end

    plugins
  end
end
