namespace :aathichudi do

  desc "copy data in wiki as first revision"
  task :create_first_revision => :environment do
    user = User.find_by_email('aramseyavirumbu@gmail.com')
    WikiVersion.destroy_all
    Wiki.all.each do |wiki|
      WikiVersion.create(wiki.attributes.merge(:user => user, :wiki => wiki, :version => 1))
    end
  end

end