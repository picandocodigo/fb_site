require 'net/https'
require 'uri'
require 'json'

# Access a user's GitHub profile and get the top languages used by the
# projects the user has worked on.
module GitHub
  def self.getstuff(token)
    uri = URI.parse('https://api.github.com/user/repos?type=owner&per_page=100')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = { 'Authorization' => "token #{token}" }
    request = Net::HTTP::Get.new(uri.request_uri, headers)
    response = http.request(request)
    data = JSON.parse(response.body)

    projects(data)
  end

  def self.auth_token
    if File.exist?(File.expand_path(__dir__ + '/.env'))
      env = File.expand_path(__dir__ + '/.env')

      File.readlines(env).each do |line|
        values = line.split('=')
        ENV[values[0]] = values[1]
      end
    end
    ENV['GITHUB_AUTH_TOKEN'] || ENV['GITHUB']
  end

  def self.projects(data)
    languages = {}
    data.each do |project|
      lang = project['language']
      (languages[lang] ? languages[lang] += 1 : languages[lang] = 1) if lang
    end

    languages.sort_by { |_k, v| v }.reverse
  end
end
