class MailersController < ApplicationController
  before_action :authenticate_user!, except: [:send_feedback]

  def mass_mail
    authorize! :mass_mail, :emails
    @mass_mailout = ::FormObjects::MassMailout.new
    @specialties = Specialty.joins(:student_profiles)
    @course_years = StudentProfile.distinct.pluck(:course_year)
    @groups = StudentProfile.distinct.pluck(:group)
  end

  def send_mailout
    authorize! :send_mailout, :emails
    users = ::QueryObjects::FindUsersForMailout.new(params).call
    mailout_params = mass_mailout_params
    mailout_params[:users] = users
    @mass_mailout = ::FormObjects::MassMailout.new(mailout_params)
    if @mass_mailout.valid?
      users_emails = users.pluck(:email)
      text = mass_mailout_params[:text]
      subject = mass_mailout_params[:subject]
      attachment = mass_mailout_params[:attachment]
      if attachment
        attachment_data = { path: File.absolute_path(attachment.tempfile),
                            name: attachment.original_filename }
      else
        attachment_data = nil
      end
      UserMassMailer.send_mailout(users_emails, subject, text, attachment_data).deliver_now
      flash[:success] = t('email_sent')
      redirect_to mailers_mass_mail_path
    else
      @specialties = Specialty.joins(:student_profiles)
      @course_years = StudentProfile.distinct.pluck(:course_year)
      @groups = StudentProfile.distinct.pluck(:group)
      render :mass_mail
    end
  end

  def send_feedback
    @user = current_or_guest_user
    @feedback_message = ::FormObjects::UserFeedback.new(feedback_params)
    respond_to do |format|
      format.js do
        if @feedback_message.valid?
          user_email = feedback_params[:user_email]
          text = feedback_params[:text]
          FeedbackMailer.feedback_from_user(user_email, text).deliver_now
          FeedbackMailer.notify_user_of_getting_feedback(user_email).deliver_now
          flash[:success] = t('email_sent')
          @redirect_url = root_path
        end
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
      format.js do
        if @contact_message.valid?
          subject = contact_message_params[:subject]
          text = contact_message_params[:text]
          ContactUserMailer.send_email_to_user(@sender, @recipient, subject, text).deliver_now
          flash[:success] = t('email_sent')
          @redirect_url = user_path(@recipient)
        end
      end
    end

  end

  private

  def mass_mailout_params
    params.require(:form_objects_mass_mailout).permit(:subject, :text, :role,
                                   :specialty_ids, :course_years,
                                   :groups, :attachment, :users)
  end

  def feedback_params
    params.require(:form_objects_user_feedback).permit(:text, :user_email)
  end

  def contact_message_params
    params.require(:form_objects_contact_message).permit(:subject, :text, :recipient_id)
  end

end
