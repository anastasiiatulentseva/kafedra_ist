class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :set_subjects, :save_subjects, :to => :own_subjects

    can :show, User
    can :read, Article
    can :manage, Workbook if user.teacher?
    can :own_subjects, User, id: user.id if user.teacher?
    can :read, Workbook if user.student?

    can :manage, :all if user.admin?
  end
end
