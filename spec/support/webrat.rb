Webrat.configure do |config|
  config.mode = :rack
end

module Webrat
  module Logging #:nodoc:
    def logger
      Rails.logger
    end
  end
end


RSpec.configure do |config|
  config.include Rack::Test::Methods
end
