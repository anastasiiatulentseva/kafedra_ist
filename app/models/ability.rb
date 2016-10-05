class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :choose_subjects, :save_subjects, :to => :own_subjects
    alias_action :mass_mail, :send_mailout, :to => :send_mass_mailout

    can :show, User unless user.guest?
    can :read, Article
    can :send_feedback

    can :read, Workbook if user.student?

    if user.teacher? && user.teacher_profile.present?
      can [:read, :create], Workbook
      can [:update, :destroy], Workbook.with_subject_ids(user.teacher_profile.subjects)
      can :own_subjects, User, id: user.id
    end


    if user.teacher?
      can :send_mass_mailout, :emails
      can :read, TeachersSchedule
    end

    cannot :read, :dashboard unless user.admin?
    can :manage, :all if user.admin?
  end
end
