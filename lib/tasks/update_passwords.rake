require 'securerandom'

namespace :aathichudi do

  desc "Update password for all users"
  task :update_passwords => :environment do
    users = User.where("email <> 'aramseyavirumbu@gmail.com'")
    users.each do |user|
      password = SecureRandom.uuid.first(6)
      user.update_attributes!(password: password, password_confirmation: password)
      puts [user.email, password].join('|')
    end
  end

end