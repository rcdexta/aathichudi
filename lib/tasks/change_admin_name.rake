namespace :aathichudi do

  desc "change admin name"
  task :admin_name => :environment do
    @locale = YAML.load(File.read("#{Rails.root}/config/locales/ta.yml")).symbolize_keys[:ta]
    user = User.find_by_email('aramseyavirumbu@gmail.com')
    user.update_attribute(:name, @locale['admin_name'])
  end

end