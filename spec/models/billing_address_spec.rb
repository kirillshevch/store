require 'rails_helper'
RSpec.describe BillingAddress, type: :model do
  let(:billing_address) { FactoryGirl.create(:billing_address) }

  context 'testing associations' do
    it { expect(billing_address).to belong_to(:country) }
    it { expect(billing_address).to belong_to(:user) }
    it { expect(billing_address).to belong_to(:order) }
  end
end
