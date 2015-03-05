require 'rails_helper'

RSpec.describe CreditCard, :type => :model do
  let(:credit_card) { FactoryGirl.create(:credit_card) }

  context 'testing validations' do
    it { expect(credit_card).to validate_presence_of(:number) }
    it { expect(credit_card).to validate_presence_of(:cvv) }
    it { expect(credit_card).to validate_presence_of(:month) }
    it { expect(credit_card).to validate_presence_of(:year) }
  end

  context 'testing associations' do
    it { expect(credit_card).to belong_to(:user) }
  end
end
