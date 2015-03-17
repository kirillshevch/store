class Ability
  include CanCan::Ability

  def initialize(user, order)
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
        can :manage, OrderItem, order_id: order.id
        can :new, [ShippingAddress, BillingAddress, CreditCard]
        can [:create, :update], [ShippingAddress, BillingAddress, CreditCard], user_id: user.id
        can :manage, Order, user_id: user.id
        can :new, Review
        can :create, Review, user_id: user.id
      end
    else
      can :read, [Book, Category, Country]
      can :manage, Order, id: order.id
      can :new, [ShippingAddress, BillingAddress, CreditCard]
      can [:create, :update], [ShippingAddress, BillingAddress, CreditCard, OrderItem, Order]
    end
  end
end