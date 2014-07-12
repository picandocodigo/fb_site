require 'net/https'
require 'uri'
require 'json'

module GitHub

  def self.getstuff
    languages = {}

    env = File.expand_path(File.dirname(__FILE__)) + "/.env"

    File.readlines(env).each do |line|
      values = line.split('=')
      ENV[values[0]] = values[1]
    end

    uri = URI.parse("https://api.github.com/user/repos?type=owner&per_page=100")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = {"Authorization" => "token #{ENV['GITHUB_AUTH_TOKEN']}"}
    request = Net::HTTP::Get.new(uri.request_uri, headers)
    response = http.request(request)
    data = JSON.parse(response.body)

    #require 'debugger';debugger
    #    data.scan(/\"language\":\ \"([a-zA-Z\ \-]*)/) do |m|
    data.each do |project|
      lang = project['language']
      (languages[lang] ? languages[lang] += 1 : languages[lang] = 1) if lang
    end

    languages.sort_by{|k, v| v}.reverse
  end
end
