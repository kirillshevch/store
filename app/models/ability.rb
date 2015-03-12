class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user.admin?
      can :access, :rails_admin
      can :dashboard
      can :manage, [Book, Author, Category, Order]
      can :update, Review
      can :state, Order
    elsif user
      can :manage, [ShippingAddress, BillingAddress, CreditCard, OrderItem]
      can :manage, Order, user_id: user.id
      can [:new, :create], Review, user_id: user.id
    else
      can :manage, [ShippingAddress, BillingAddress, CreditCard, OrderItem, Order]
    end
  end
end