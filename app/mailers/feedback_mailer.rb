class FeedbackMailer < ApplicationMailer

  default from: 'noreply@kafist.bumib.edu.ua'

  def feedback_from_user(user_email, text)
    @user_email = user_email
    @text = text
    mail to: 'nporvatova@gmail.com', subject: "Feedback from homepage"
  end

  def notify_user_of_getting_feedback(user_email)
    @user_email = user_email
    mail to: user_email, subject: "You have sent us feedback"
  end
end
