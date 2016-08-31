# Preview all emails at http://localhost:3000/rails/mailers/user_mass_mailer
class UserMassMailerPreview < ActionMailer::Preview

  def send_mailout
    UserMassMailer.send_mailout(User.first.email, "subject", "text", nil)
  end

end
