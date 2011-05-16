class AdminNotifier < ActionMailer::Base
  default :from => "admin@aramseyavirumbu.com"

  def notify_wiki_submission(wiki_version)
    @wiki_version = wiki_version
    mail(:to => AppConfig.admin,
         :subject => t(:admin_notification_subject, :paadal => wiki_version.paadal))
  end
end
