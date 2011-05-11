class AdminNotifier < ActionMailer::Base
  default :from => "admin@aramseyavirumbu.com"

  def notify_wiki_submission(wiki_version)
    @wiki_version = wiki_version
    mail(:to => AppConfig.admin,
         :subject => "#{@wiki_version.paadal} - #{t(:admin_notification_subject)}")
  end
end
