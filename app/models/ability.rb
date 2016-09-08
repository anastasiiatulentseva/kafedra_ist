class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :choose_subjects, :save_subjects, :to => :own_subjects
    alias_action :mass_mail, :send_mailout, :to => :send_mass_mailout
    can :show, User unless user.guest?
    can :read, Article


    if user.teacher? && user.teacher_profile.present?
      can :manage, Workbook
      can :own_subjects, User, id: user.id
    end

    if user.teacher? || user.admin?
      can :send_mass_mailout, :emails
    end

    can :send_feedback
    can :read, Workbook if user.student?

    can :manage, :all if user.admin?
  end
end
