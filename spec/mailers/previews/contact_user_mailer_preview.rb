# Preview all emails at http://localhost:3000/rails/mailers/contact_user_mailer
class ContactUserMailerPreview < ActionMailer::Preview
  def contact_user
    ContactUserMailer.send_email_to_user(User.active.last, User.active.first, 'subject', 'email text here')
  end
end
