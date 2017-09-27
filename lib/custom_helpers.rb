# Custom functions for the different providers in `/lib`
module CustomHelpers
  def text(string)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      no_intra_emphasis: true,
      lax_spacing: true
    )
    markdown.render(t(string))
  end

  def github
    GitHub.getstuff
  end

  def time
    Time.now.strftime('%F')
  end

  def rubygems
    RubyGems.info 'picandocodigo'
  end

  def wordpress_plugins
    WordPressPlugins.get_plugins 'fernandobt'
  end
end
