# Custom functions for the different providers in `/lib`
module CustomHelpers
  def text(string, extra_content = '')
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      no_intra_emphasis: true,
      lax_spacing: true
    )
    markdown.render(t(string) + extra_content)
  end

  def github
    load_env unless ENV['GITHUB_AUTH_TOKEN']
    GitHub.getstuff(ENV['GITHUB_AUTH_TOKEN'])
  end

  def time
    Time.now.strftime('%d %m %Y')
  end

  def rubygems
    load_env unless ENV['RUBYGEMS']
    gems = RubyGems.info(ENV['RUBYGEMS'])
    elastic, personal = gems.partition do |gem|
      gem['name'].match?(/^elastic/)
    end
    { personal: personal, elastic: elastic }
  end

  def wordpress_plugins
    load_env unless ENV['WORDPRESS']
    WordPressPlugins.plugins(ENV['WORDPRESS'])
      .sort_by { |a| -a['downloaded'] }
  end

  def skills
    ['Ruby', 'Ruby On Rails', 'Agile Methodologies (Scrum, XP)',
     'Team Management', 'Linux', 'System Administration', 'SQL', 'Git',
     'CSS', 'HTML', 'JavaScript', 'Bash', 'Java',
     'WordPress', 'PHP', 'Vagrant', 'Docker']
      .shuffle
      .join(', ')
  end

  def format_number(number)
    number.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(',').reverse
  end

  private

  def load_env
    return if ENV['GITHUB_AUTH_TOKEN'] && ENV['RUBYGEMS'] && ENV['WORDPRESS']

    env = File.expand_path(__dir__ + '/.env')

    File.readlines(env).each do |line|
      values = line.split('=')
      ENV[values[0]] = values[1].delete("\n")
    end
  end
end
