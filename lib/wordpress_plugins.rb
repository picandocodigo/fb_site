module WordPressPlugins
  require 'nokogiri'
  require 'open-uri'

  def self.get_plugins user
    @plugins = Array.new
    #Nokogiri FTW
    url = "http://wordpress.org/extend/plugins/profile/#{user}"
    doc = Nokogiri::HTML( open (url) )
    doc.css('div.plugin-block').each do |p|
      @plugins.push p
    end
    
    return @plugins
  end
end
