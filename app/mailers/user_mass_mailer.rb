class UserMassMailer < ApplicationMailer

  default from: 'noreply@kafedra_ist.bumib.edu.ua'

  def send_mailout(users_emails, subject, text, attachment_data)
    @text = text
    @subject = subject
    if attachment_data
      attachments[attachment_data[:name]] = File.read(attachment_data[:path])
    end

    mail bcc: users_emails, subject: subject
  end
end
