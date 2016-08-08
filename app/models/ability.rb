class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new


    can :show, User
    can :read, Article
    can :read, Workbook if user.roles.any?
    can :manage, :all if user.admin?
  end
end
