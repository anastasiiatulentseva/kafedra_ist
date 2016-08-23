class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :choose_subjects, :save_subjects, :to => :own_subjects

    can :show, User unless user.guest?
    can :read, Article

    if user.teacher? && user.teacher_profile.present?
      can :manage, Workbook
      can :own_subjects, User, id: user.id
    end

    can :read, Workbook if user.student?

    can :manage, :all if user.admin?
  end
end
