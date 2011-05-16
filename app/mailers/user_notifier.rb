class UserNotifier < ActionMailer::Base
  default :from => "aramseyavirumbu@gmail.com"

  def welcome_mail(user)
    unless user.email.blank?
      mail(:to => user.email,
         :subject => t(:welcome_mail_subject))
    end
  end

  def wiki_approved_mail(wiki_version)
    @wiki_version = wiki_version
    unless wiki_version.user.email.blank?
      mail(:to => wiki_version.user.email,
          :subject => t(:wiki_accepted_mail_subject, :paadal => wiki_version.paadal))
    end
  end
end
