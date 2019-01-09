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
    GitHub.getstuff(env['GITHUB_AUTH_TOKEN'])
  end

  def time
    Time.now.strftime('%d %m %Y')
  end

  def rubygems
    RubyGems.info(env['RUBYGEMS'])
  end

  def wordpress_plugins
    WordPressPlugins.plugins(env['WORDPRESS'])
  end

  def skills
    ["Ruby", "Ruby On Rails", "Agile Methodologies (Scrum, XP)", "Team Management", "Linux", "System Administration", "SQL", "Git", "CSS", "HTML", "JavaScript", "Bash", "Java", "WordPress", "PHP", "Vagrant", "Docker"]
    .shuffle
    .join(', ')
  end

  private

  def env
    env = File.expand_path(__dir__ + '/.env')
    env_vars = {}

    File.readlines(env).each do |line|
      values = line.split('=')
      env_vars[values[0]] = values[1].delete("\n")
    end
    env_vars
  end
end
