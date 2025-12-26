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
    GitHub.getstuff(env['GITHUB'] || env['GITHUB_AUTH_TOKEN'])
  end

  def time
    Time.now.strftime('%d %m %Y')
  end

  def rubygems
    gems = RubyGems.info(env['RUBYGEMS'])
    elastic, personal = gems.partition do |gem|
      gem['name'].match?(/^elastic/)
    end
    { personal: personal, elastic: elastic }
  end

  def wordpress_plugins
    WordPressPlugins.plugins(env['WORDPRESS'])
      .sort_by { |a| -a['downloaded'] }
  end

  def blog_posts
    Blog.info(env['BLOG_FEED'])
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

  def env
    if File.exist?(File.expand_path(__dir__ + '/.env'))
      env = File.expand_path(__dir__ + '/.env')
      env_vars = {}

      File.readlines(env).each do |line|
        values = line.split('=')
        env_vars[values[0]] = values[1].delete("\n")
      end
      env_vars
    else
      {
        'GITHUB' => ENV['GITHUB'],
        'WORDPRESS' => ENV['WORDPRESS'],
        'RUBYGEMS' => ENV['RUBYGEMS'],
        'GITHUB_AUTH_TOKEN' => ENV['GITHUB_AUTH_TOKEN']
        'BLOG_FEED' => ENV['BLOG_FEED']
      }
    end
  end
end
