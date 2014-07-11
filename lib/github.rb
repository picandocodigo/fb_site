module GitHub

  def self.getstuff
    languages = {}

    env = File.expand_path(File.dirname(__FILE__)) + "/.env"

    File.readlines(env).each do |line|
      values = line.split('=')
      ENV[values[0]] = values[1]
    end
    data = `curl -s -u #{ENV['GITHUB_AUTH_TOKEN']}:x-oauth-basic \
      "https://api.github.com/user/repos?type=owner&per_page=100"`


    data.scan(/\"language\":\ \"([a-zA-Z\ \-]*)/) do |m|
      languages[m[0]] ? languages[m[0]] += 1 : languages[m[0]] = 1
    end

    languages.sort_by{|k, v| v}.reverse
  end
end
