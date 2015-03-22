require 'rails_helper'
require 'cancan/matchers'

describe 'User' do
  describe 'abilities' do
    context 'when user signed in as admin' do
      let(:admin) { FactoryGirl.create(:admin) }
      let(:order) { FactoryGirl.create(:order, user_id: admin.id) }
      subject(:ability) { Ability.new(admin, order) }

      it { should be_able_to(:read, :all) }
      it { should be_able_to(:access, :rails_admin) }
      it { should be_able_to(:manage, Book.new) }
      it { should be_able_to(:manage, Author.new) }
      it { should be_able_to(:manage, Category.new) }
      it { should be_able_to(:manage, Order.new) }
      it { should be_able_to(:manage, Review.new) }
      it { should be_able_to(:new, Coupon.new) }
      it { should be_able_to(:create, Coupon.new) }
      it { should be_able_to(:update, Coupon.new) }
      it { should be_able_to(:all_events, Order.new) }
    end

    context 'when user signed in as user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:order) { FactoryGirl.create(:order, user_id: user.id) }
      subject(:ability) { Ability.new(user, order) }

      it { should be_able_to(:manage, OrderItem.new(order_id: order.id)) }
      it { should be_able_to(:new, BillingAddress.new) }
      it { should be_able_to(:new, ShippingAddress.new) }
      it { should be_able_to(:create, BillingAddress.new(user_id: user.id)) }
      it { should be_able_to(:update, BillingAddress.new(user_id: user.id)) }
      it { should be_able_to(:create, ShippingAddress.new(user_id: user.id)) }
      it { should be_able_to(:update, ShippingAddress.new(user_id: user.id)) }
      it { should be_able_to(:manage, Order.new(user_id: user.id)) }
      it { should be_able_to(:new, Review.new) }
      it { should be_able_to(:create, Review.new(user_id: user.id)) }
    end

    context 'when user no login' do
      let(:user) { nil }
      let(:order) { FactoryGirl.create(:order) }
      subject(:ability) { Ability.new(user, order) }

      it { should be_able_to(:manage, order) }
      it { should be_able_to(:manage, OrderItem.new(order_id: order.id)) }
      it { should be_able_to(:new, BillingAddress.new) }
      it { should be_able_to(:create, BillingAddress.new) }
      it { should be_able_to(:update, BillingAddress.new) }
      it { should be_able_to(:new, ShippingAddress.new) }
      it { should be_able_to(:create, ShippingAddress.new) }
      it { should be_able_to(:update, ShippingAddress.new) }
    end
  end
end