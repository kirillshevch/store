require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#current_order' do
    context 'no login user' do
      let(:order) { FactoryGirl.create(:order) }

      before do
        controller.stub(:current_user).and_return nil
        Order.stub(:find_by).and_return order
      end

      it 'returns order' do
        expect(controller.current_order).to eq(order)
      end
    end

    context 'logged user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:order) { FactoryGirl.create(:order) }

      before do
        controller.stub(:current_user).and_return user
      end

      context 'user has no order' do
        before do
          user.stub_chain(:orders, :find_by).and_return nil
          user.stub_chain(:orders, :create).and_return order
        end

        it 'returns order' do
          expect(controller.current_order).to eq(order)
        end
      end

      context 'user have order' do
        before do
          user.stub_chain(:orders, :find_by).and_return order
        end

        it 'returns order' do
          expect(controller.current_order).to eq(order)
        end
      end
    end
  end

  describe '#load_user' do
    let(:user) { FactoryGirl.create(:user) }

    context 'logged user' do

      before do
        controller.stub(:current_user).and_return user
      end

      it 'load_user return user' do
        expect(controller.load_user).to eq(user)
      end
    end

    context 'no login user' do
      it 'load_user return nil' do
        expect(controller.load_user).to eq(nil)
      end
    end
  end

  context 'testing private method' do
    describe '#set_order' do
      context 'user login' do
        let(:user) { FactoryGirl.create(:user) }

        before do
          controller.stub(:current_user).and_return user
        end

        it 'returns nil' do
          expect(controller.send(:set_order)).to eq(nil)
        end
      end

    end
  end
end