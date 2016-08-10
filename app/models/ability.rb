class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new


    can :show, User
    can :read, Article
    can :manage, Workbook if user.teacher?
    can :set_subjects, User if user.teacher?
    can :read, Workbook if user.student?



    can :manage, :all if user.admin?
  end
end
