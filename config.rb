# Require everything in /lib:
Dir['./lib/*.rb'].each { |l| require l }

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout

#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

activate :directory_indexes
page '/cv/index.html', layout: :cv
mime_type :haml, "text/html"

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

activate :i18n, langs: %i[en es], mount_at_root: :en
activate :gzip
activate :relative_assets
activate :sprockets

# Reload the browser automatically whenever files change
# configure :development do
#  activate :livereload
# end

# Methods defined in the helpers block are available in templates
helpers CustomHelpers

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'images'

set :markdown_engine, :redcarpet
set :markdown

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.build_before = true
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
