require 'rails_helper'

RSpec.describe CheckoutForm do
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order, user_id: user.id) }

  describe 'validations' do

    context 'billing address' do
      let(:checkout_form) { CheckoutForm.new(user, order, :billing_address) }

      it { expect(checkout_form).to validate_presence_of(:billing_first_name) }
      it { expect(checkout_form).to validate_presence_of(:billing_last_name) }
      it { expect(checkout_form).to validate_presence_of(:billing_zipcode) }
      it { expect(checkout_form).to validate_presence_of(:billing_city) }
      it { expect(checkout_form).to validate_presence_of(:billing_phone) }
      it { expect(checkout_form).to validate_presence_of(:billing_country_id) }
    end

    context 'shipping address' do
      let(:checkout_form) { CheckoutForm.new(user, order, :shipping_address) }

      it { expect(checkout_form).to validate_presence_of(:shipping_first_name) }
      it { expect(checkout_form).to validate_presence_of(:shipping_last_name) }
      it { expect(checkout_form).to validate_presence_of(:shipping_zipcode) }
      it { expect(checkout_form).to validate_presence_of(:shipping_city) }
      it { expect(checkout_form).to validate_presence_of(:shipping_phone) }
      it { expect(checkout_form).to validate_presence_of(:shipping_country_id) }
    end

    context 'payment' do
      let(:checkout_form) { CheckoutForm.new(user, order, :payment) }

      it { expect(checkout_form).to validate_presence_of(:number) }
      it { expect(checkout_form).to validate_presence_of(:cvv) }
      it { expect(checkout_form).to validate_presence_of(:month) }
      it { expect(checkout_form).to validate_presence_of(:year) }
    end

    context 'delivery' do
      let(:checkout_form) { CheckoutForm.new(user, order, :delivery) }

      it { expect(checkout_form).to validate_presence_of(:delivery) }
    end

  end

  describe '#billing_address' do
    let(:checkout_form) { CheckoutForm.new(user, order, :example) }
    context 'with billing address' do
      let!(:billing_address) { FactoryGirl.create(:billing_address, order_id: order.id) }

      it 'returns billing address' do
        expect(checkout_form.send(:billing_address)).to eq(billing_address)
      end
    end

    context 'without billing address' do
      let(:billing_address) { order.build_billing_address }

      before do
        allow(checkout_form).to receive(:billing_address).and_return billing_address
      end

      it 'returns build billing address' do
        expect(checkout_form.send(:billing_address)).to eq(billing_address)
      end
    end
  end

  describe '#shipping_address' do
    let(:checkout_form) { CheckoutForm.new(user, order, :example) }
    context 'with shipping address' do
      let!(:shipping_address) { FactoryGirl.create(:shipping_address, order_id: order.id) }

      it 'returns billing address' do
        expect(checkout_form.send(:shipping_address)).to eq(shipping_address)
      end
    end

    context 'without shipping address' do
      let(:shipping_address) { order.build_shipping_address }

      before do
        allow(checkout_form).to receive(:shipping_address).and_return shipping_address
      end

      it 'returns build shipping address' do
        expect(checkout_form.send(:shipping_address)).to eq(shipping_address)
      end
    end
  end

  describe '#credit_card' do
    let(:checkout_form) { CheckoutForm.new(user, order, :example) }
    context 'with card' do
      let!(:credit_card) { FactoryGirl.create(:credit_card, order_id: order.id) }

      it 'returns creadit card' do
        expect(checkout_form.send(:credit_card)).to eq(credit_card)
      end
    end

    context 'without card' do
      let(:credit_card) { order.credit_card }

      before do
        allow(checkout_form).to receive(:credit_card).and_return credit_card
      end

      it 'returns build shipping address' do
        expect(checkout_form.send(:credit_card)).to eq(credit_card)
      end
    end
  end

  describe '#save' do
    let(:checkout_form) { CheckoutForm.new(user, order, :example) }

    context 'form not valid' do

      before do
        allow(checkout_form).to receive(:valid?).and_return false
      end

      it 'returns false' do
        expect(checkout_form.save).to eq(false)
      end
    end

    context 'form valid' do
      before do
        allow(checkout_form).to receive(:valid?).and_return true
      end

      it 'returns false' do
        expect(checkout_form.save).to eq(true)
      end
    end
  end

  describe '#checkout_complete' do
    let(:checkout_form) { CheckoutForm.new(user, order, :example) }

    context 'if form valid' do
      before do
        allow(checkout_form).to receive(:valid?).and_return true
      end

      it 'returns true' do
        expect(checkout_form.checkout_complete).to eq(true)
      end
    end
    context 'if form valid' do
      before do
        allow(checkout_form).to receive(:valid?).and_return true
      end

      it 'returns true' do
        expect(checkout_form.checkout_complete).to eq(true)
      end
    end
  end

end