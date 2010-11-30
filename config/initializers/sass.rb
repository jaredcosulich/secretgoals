#Sass::Plugin.options[:template_location] = 'public/stylesheets/sass'
#Sass::Plugin.options[:css_location] = 'tmp/stylesheets/compiled'
Sass::Plugin.options[:cache_location] = './tmp/sass-cache'

Rails.configuration.middleware.insert_before(Rack::Lock, Rack::Static, :root => 'tmp/', :urls => ['/stylesheets/compiled'])
