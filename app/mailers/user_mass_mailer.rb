class UserMassMailer < ApplicationMailer

  default from: 'nporvatova@gmail.com'

  def send_mailout(users_emails, subject, text, attachment)
    @text = text
    @subject = subject
    if attachment
      attachments['attachment'] = File.read(attachment)
    end

    mail bcc: users_emails, subject: subject
  end
end
