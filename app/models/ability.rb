class Ability
  include CanCan::Ability

  def initialize(user)
    # TODO get current order and refactoring

    if user
      if user.admin?
        can :read, :all
        can :access, :rails_admin
        can :dashboard
        can :manage, [Book, Author, Category, Order, Review]
        can [:new, :create, :update], Coupon
        can :all_events, Order
      else
        can :read, [Book, Category, Country]
        can :manage, OrderItem
        can :manage, [ShippingAddress, BillingAddress, CreditCard], user_id: user.id
        can :manage, Order, user_id: user.id
        can :new, Review
        can :create, Review, user_id: user.id
      end
    else
      can :read, [Book, Category, Country]
      can :manage, [ShippingAddress, BillingAddress, CreditCard, OrderItem, Order]
    end
  end
end