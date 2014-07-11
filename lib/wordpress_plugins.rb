module WordPressPlugins
  require 'nokogiri'
  require 'open-uri'

  def self.get_plugins user
    @plugins = []
    #Nokogiri FTW
    url = "http://profiles.wordpress.org/#{user}"
    doc = Nokogiri::HTML( open (url) )
    doc.css('div#content-plugins ul li').each do |p|
      plugin = {
        url: p.children[1].children[1].attributes['href'].value,
        name: p.children[1].children[1].children[0].content,
        downloads: p.children[3].children[0].content
      }
      @plugins.push plugin
    end

    @plugins
  end
end
