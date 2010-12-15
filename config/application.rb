require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'pp'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Secretgoals
  class Application < Rails::Application
    attr_accessor :cache_buster, :host
    config.app_generators do |g|
      g.template_engine :haml
      g.test_framework :rspec
      g.helper false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w(jquery-1.4.4 rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    config.before_initialize do
      Dir["#{Rails.root}/lib/ruby_ext/*.rb"].sort.each do |file|
        require file
      end
      Rails.application.cache_buster = Time.now.to_i
      Rails.application.host = case Rails.env
        when "development": "localhost:3000"
        when "production" : "www.secretgoals.com"
        when "staging" : "staging.secretgoals.com"
        else "#{Rails.env}.secretgoals.com"
                               end

      config.action_mailer.default_url_options = {:host => Rails.application.host}
    end

  end
end
