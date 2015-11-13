require './lib/redcarpet_header_fix'
require './lib/extra_lexer_tabs'

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :fonts_dir, 'fonts'

set :markdown_engine, :redcarpet

set :markdown, :fenced_code_blocks => true, :smartypants => true, :disable_indented_code_blocks => true, :prettify => true, :tables => true, :with_toc_data => true, :no_intra_emphasis => true

# Activate the syntax highlighter
activate :syntax

# This is needed for Github pages, since they're hosted on a subdomain
activate :relative_assets
set :relative_links, true

activate :livereload

activate :directory_indexes

# Add custom themes for different pages
# The API theme is overridden in docs/*/jsonapi
page "/docs/0.9/*", :layout => "0.9"
page "/docs/1.0/*", :layout => "1.0"
page "/docs/2.x/*", :layout => "2.x"

# Links in the menubar and front page load the default_version of Flapjack's docs.
# The following line is the only place to update when you want to use a new default version.
set :default_version, "1.0"
set :layout, "main"

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

