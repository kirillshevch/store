class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user && user.admin?
      can :access, :rails_admin
      can :dashboard
      can :manage, [Book, Author, Category]
      can :update, [Review, Order]
    end
  end
end