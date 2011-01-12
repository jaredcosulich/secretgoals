ActionMailer::Base.register_interceptor(NonProductionMailInterceptor) unless Rails.env.production? || Rails.env.test?
