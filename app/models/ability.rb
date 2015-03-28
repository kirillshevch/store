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
        can :manage, OrderItem, order_id: order.id
        can :new, [ShippingAddress, BillingAddress]
        can [:create, :update], [ShippingAddress, BillingAddress], user_id: user.id
        can :manage, Order, id: order.id, user_id: user.id
        can :new, Review
        can :create, Review, user_id: user.id
      end
    else
      can :manage, Order, id: order.id
      can :manage, OrderItem, order_id: order.id
      can :new, [ShippingAddress, BillingAddress]
      can [:create, :update], [ShippingAddress, BillingAddress], order_id: order.id
    end
  end
end