class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_topics.subject
  #
  def sendmail_blog(blog)
    @topics = topic

    mail to: "banibanibani50@gmail.com"
    subject: '【Topics】トピックが投稿されました'
  end
end
