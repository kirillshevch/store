require 'rails_helper'

RSpec.describe Permitted do
  describe '#step_permitted' do
    context 'step billing address' do
      let(:permitted) { Permitted.new(:billing_address) }
      it 'returns array keys' do
        expect(permitted.step_permitted).to eq([:billing_first_name, :billing_last_name, :billing_addr, :billing_zipcode, :billing_city,
                                                :billing_phone, :billing_country_id, :copyaddress, :form_step])
      end
    end

    context 'step shipping address' do
      let(:permitted) { Permitted.new(:shipping_address) }
      it 'returns array keys' do
        expect(permitted.step_permitted).to eq([:shipping_first_name, :shipping_last_name, :shipping_addr, :shipping_zipcode, :shipping_city,
                                                :shipping_phone, :shipping_country_id])
      end
    end

    context 'step delivery' do
      let(:permitted) { Permitted.new(:delivery) }
      it 'returns array keys' do
        expect(permitted.step_permitted).to eq([:delivery])
      end
    end

    context 'step delivery' do
      let(:permitted) { Permitted.new(:payment) }
      it 'returns array keys' do
        expect(permitted.step_permitted).to eq([:number, :month, :year, :cvv])
      end
    end

    context 'step delivery' do
      let(:permitted) { Permitted.new(:confirm) }
      it 'returns array keys' do
        expect(permitted.step_permitted).to eq([:state])
      end
    end
  end
end