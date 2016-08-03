class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new


    can :show, User
    can :read, Article

    can :manage, :all if user.admin?
  end
end
