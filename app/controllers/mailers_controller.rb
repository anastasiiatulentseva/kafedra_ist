class MailersController < ApplicationController

  def send_feedback
    @user = current_or_guest_user
    user_email = params[:user_email]
    text = params[:text]
    FeedbackMailer.feedback_from_user(user_email, text).deliver_now
    FeedbackMailer.notify_user_of_getting_feedback(user_email).deliver_now
    flash[:success] = "Feedback has been sent"
    redirect_to root_path
  end


end
