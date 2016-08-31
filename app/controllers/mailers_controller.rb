class MailersController < ApplicationController

  def mass_mail
    @specialties = Specialty.joins(:student_profiles)
    @course_years = StudentProfile.distinct.pluck(:course_year)
    @groups = StudentProfile.distinct.pluck(:group)
  end

  def send_mailout
    users = ::QueryObjects::FindUsersForMailout.new(params).call
    users_emails = users.pluck(:email)
    text = params[:text]
    subject = params[:subject]
    attachment = params[:attachment]
    if attachment
      attachment_path = File.absolute_path(attachment.tempfile)
    else
      attachment_path = nil
    end
    if users.any?
      UserMassMailer.send_mailout(users_emails, subject, text, attachment_path).deliver_now
      flash[:success] = 'Email has been sent'
      redirect_to mailers_mass_mail_path
    else
      @specialties = Specialty.joins(:student_profiles)
      @course_years = StudentProfile.distinct.pluck(:course_year)
      @groups = StudentProfile.distinct.pluck(:group)
      flash[:danger] = 'No users in selected group'
      render 'mass_mail'
    end

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
