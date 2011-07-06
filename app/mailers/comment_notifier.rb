class CommentNotifier < ActionMailer::Base
  default :from => "admin@aramseyavirumbu.com"

  def send_mail(comment)
    @comment = comment
    mail(:to => AppConfig.admin, :subject => t(:comment_notification_mail_subject))
  end

end
