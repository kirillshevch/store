require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  let(:shipping_address) { FactoryGirl.create(:shipping_address) }

  context 'testing associations' do
    it { expect(shipping_address).to belong_to(:country) }
    it { expect(shipping_address).to belong_to(:user) }
    it { expect(shipping_address).to belong_to(:order) }
  end
end
