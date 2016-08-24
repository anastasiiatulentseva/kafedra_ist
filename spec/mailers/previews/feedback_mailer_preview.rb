# Preview all emails at http://localhost:3000/rails/mailers/feedback_mailer
class FeedbackMailerPreview < ActionMailer::Preview
  def send_feedback_to_admin
    FeedbackMailer.feedback_from_user('user@user.ru', "bla")
  end

  def notify_user_of_feedback
    FeedbackMailer.notify_user_of_getting_feedback('user@user.ru')
  end
end
