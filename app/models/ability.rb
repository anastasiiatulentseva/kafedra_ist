class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.admin?

    can :manage, User, id: user.id
    can :read, Article

  end
end
