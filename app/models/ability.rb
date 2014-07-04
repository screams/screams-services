class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :create, Scream if user.persisted?
  end
end