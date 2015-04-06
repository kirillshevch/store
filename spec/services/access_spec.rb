require 'rails_helper'

RSpec.describe Access do
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order, user_id: user.id) }

  describe '#step_access' do
    context 'step billing address' do
      let(:access) { Access.new(user, order, :billing_address) }

      context 'access allowed' do
        before do
          allow(order).to receive_message_chain(:order_items, :present?).and_return true
        end
        it { expect(access.step_access?).to eq(true) }
      end

      context 'access denied' do
        before do
          allow(order).to receive_message_chain(:order_items, :present?).and_return false
        end
        it { expect(access.step_access?).to eq(false) }
      end
    end
    context 'step shipping address' do
      let(:access) { Access.new(user, order, :shipping_address) }

      context 'access allowed' do
        before do
          allow(CheckoutForm).to receive_message_chain(:new, :valid?).and_return true
        end
        it { expect(access.step_access?).to eq(true) }
      end

      context 'access denied' do
        before do
          allow(CheckoutForm).to receive_message_chain(:new, :valid?).and_return false
        end
        it { expect(access.step_access?).to eq(false) }
      end
    end
    context 'step delivery' do
      let(:access) { Access.new(user, order, :delivery) }

      context 'access allowed' do
        before do
          allow(CheckoutForm).to receive_message_chain(:new, :valid?).and_return true
        end
        it { expect(access.step_access?).to eq(true) }
      end

      context 'access denied' do
        before do
          allow(CheckoutForm).to receive_message_chain(:new, :valid?).and_return false
        end
        it { expect(access.step_access?).to eq(false) }
      end
    end

    context 'step payment' do
      let(:access) { Access.new(user, order, :payment) }

      context 'access allowed' do
        before do
          allow(CheckoutForm).to receive_message_chain(:new, :valid?).and_return true
        end
        it { expect(access.step_access?).to eq(true) }
      end

      context 'access denied' do
        before do
          allow(CheckoutForm).to receive_message_chain(:new, :valid?).and_return false
        end
        it { expect(access.step_access?).to eq(false) }
      end
    end

    context 'step confirm' do
      let(:access) { Access.new(user, order, :confirm) }

      context 'access allowed' do
        before do
          allow(CheckoutForm).to receive_message_chain(:new, :valid?).and_return true
        end
        it { expect(access.step_access?).to eq(true) }
      end

      context 'access denied' do
        before do
          allow(CheckoutForm).to receive_message_chain(:new, :valid?).and_return false
        end
        it { expect(access.step_access?).to eq(false) }
      end
    end

    context 'step finish' do
      let(:access) { Access.new(user, order, :wicked_finish) }

      it { expect(access.step_access?).to eq(true) }
    end
  end

  describe '#error_text' do
    let(:access) { Access.new(user, order, :billing_address) }

    before do
      allow(order).to receive_message_chain(:order_items, :present?).and_return false
      access.step_access?
    end

    it 'returns error text' do
      expect(access.error_text).to eq('Select book before checkout')
    end
  end

  describe '#redirect_url' do
    let(:access) { Access.new(user, order, :billing_address) }

    before do
      allow(order).to receive_message_chain(:order_items, :present?).and_return false
      access.step_access?
    end

    it 'returns error text' do
      expect(access.redirect_url).to eq(shop_path)
    end
  end

end