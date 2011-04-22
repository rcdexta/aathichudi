module AppConfig

  def self.[](*args)
    args.inject(APP_CONFIG) { |hash, arg| hash[arg] }
  end

  def self.method_missing(method, *args)
    self[method.to_s, *args] || self[method, *args]
  end

  raw_config = File.read("#{Rails.root}/config/app_config.yml")
  settings = YAML.load(raw_config).symbolize_keys

  unless settings.blank?
    APP_CONFIG = settings.symbolize_keys
  else
    puts "Please include an app_config file for the environment you are trying to run the application against"
    abort
  end

end
