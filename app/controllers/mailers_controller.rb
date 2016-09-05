class MailersController < ApplicationController
  before_action :authenticate_user!, except: [:send_feedback]
  respond_to :js
  def mass_mail
    @specialties = Specialty.joins(:student_profiles)
    @course_years = StudentProfile.distinct.pluck(:course_year)
    @groups = StudentProfile.distinct.pluck(:group)
    authorize! :mass_mail, :emails
  end

  def send_mailout
    authorize! :send_mailout, :emails
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
    @feedback_message = ::FormObjects::UserFeedback.new(feedback_params)
    respond_to do |format|
      if @feedback_message.valid?
        format.js do
          user_email = feedback_params[:user_email]
          text = feedback_params[:text]
          FeedbackMailer.feedback_from_user(user_email, text).deliver_now
          FeedbackMailer.notify_user_of_getting_feedback(user_email).deliver_now
          flash[:success] = "Feedback has been sent"
          redirect_to root_path
        end
      else
        format.js
      end
    end
  end

  def contact_user
    @user = User.find(params[:id])
    @contact_message = ::FormObjects::ContactMessage.new
    @sender = current_user
    @recipient = @user
    render layout: false
  end

  def send_email_to_user
    @contact_message = ::FormObjects::ContactMessage.new(contact_message_params)
    @sender = current_user
    @recipient = User.find(contact_message_params[:recipient_id])
    respond_to do |format|
      if @contact_message.valid?
        format.js do
          subject = contact_message_params[:subject]
          text = contact_message_params[:text]
          ContactUserMailer.send_email_to_user(@sender, @recipient, subject, text).deliver_now
          flash[:success] = "Message has been sent"
          redirect_to user_path(@recipient)
        end
      else
        format.js
      end
    end

  end

  private

  def feedback_params
    params.require(:form_objects_user_feedback).permit(:text, :user_email)
  end

  def contact_message_params
    params.require(:form_objects_contact_message).permit(:subject, :text, :recipient_id)
  end
end
