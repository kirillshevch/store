require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:state) { FactoryGirl.create(:state) }
  let(:order) { FactoryGirl.build_stubbed(:order) }

  describe 'GET #index' do
  end
  describe 'GET #show' do
    before do
      controller.stub(:current_user).and_return user
      user.stub_chain(:orders, :find).and_return order
    end

    it 'assign @order' do
      get :show, id: order.id
      expect(assigns(:order)).to be(order)
    end
  end
  describe 'GET #delivery' do

  end
  describe 'GET #confrim' do

  end
  describe 'PUT #update' do

  end
end
