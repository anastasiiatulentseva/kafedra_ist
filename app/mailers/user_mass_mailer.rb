class UserMassMailer < ApplicationMailer

  default from: 'nporvatova@gmail.com'

  def send_mailout(users_emails, subject, text, attachment)
    @text = text
    @subject = subject
    attachments = attachment
    mail bcc: users_emails, subject: subject
  end

end
