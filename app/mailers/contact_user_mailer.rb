class ContactUserMailer < ApplicationMailer

  default from: 'noreply@kafist.bumib.edu.ua'

  def send_email_to_user(sender, recipient, subject, text)
    @subject = subject
    @text = text
    @sender = sender
    @recipient = recipient

    mail to: recipient.email, subject: subject
  end
end
