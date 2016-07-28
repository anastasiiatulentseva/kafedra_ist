class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.admin?

    can :update, User, id: user.id
    can :show, User
    can :read, Article

  end
end
