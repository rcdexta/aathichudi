Aathichudi::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = false

  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local = true
  # config.action_view.debug_rjs = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.delivery_method = :smtp


  config.action_mailer.smtp_settings = {
      :enable_starttls_auto => true,
      :address => "smtp.gmail.com", # enter smtp server address
      :port => 587, # enter port
      :domain => "gmail.com", # same as server
      :authentication => :plain,
      :user_name => "rc.thoughtworker@gmail.com",
      :password => "rock2124"
  }
  config.action_mailer.perform_deliveries = true

  config.action_mailer.default_url_options = {:host => 'localhost:3000'}


  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
end

