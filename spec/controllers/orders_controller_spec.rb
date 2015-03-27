require 'rails_helper'

RSpec.describe OrdersController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:current_order) { FactoryGirl.create(:order, user_id: user.id) }
  let!(:order_list) { FactoryGirl.create_list(:order, 3, user_id: user.id, state: :in_queue) }

  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub(:current_ability).and_return(@ability)
  end

  describe '#GET index' do
    before do
      @ability.can :index, Order
    end
    context 'User login' do
      before do
        controller.stub(:current_user).and_return user
        controller.stub(:current_order).and_return current_order
        user.stub(:orders).and_return order_list
        get :index
      end

      it 'renders :index template' do
        expect(response).to render_template :index
      end

      it 'assigns @orders' do
        expect(assigns(:orders)).to eq(order_list)
      end
    end

    context 'User not login' do
      before do
        controller.stub(:current_user).and_return nil
        controller.stub(:current_order).and_return current_order
        user.stub(:orders).and_return order_list
        get :index
      end
    end
  end
end