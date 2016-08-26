class MailersController < ApplicationController

  def mass_mail
    @users = User.active
    @specialties = Specialty.all
    @groups = StudentProfile.pluck(:group)
  end

  def send_mailout
    users = ::QueryObjects::FindUsersForMailout.new(params).call
    users_emails = users.pluck(:email)
    text = params[:text]
    subject = params[:subject]
    attachment = params[:attachment]
    # binding.pry
    UserMassMailer.send_mailout(users_emails, subject, text, attachment).deliver_now
    flash[:warning] = 'testing....'
    redirect_to mailers_mass_mail_path
  end

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
