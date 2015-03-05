require 'rails_helper'

RSpec.describe Review, :type => :model do
  let(:review) { FactoryGirl.create(:review) }

  context 'testing validations' do
    it { expect(review).to validate_numericality_of(:number) }
    it { expect(review).to validate_inclusion_of(:number).in_range(1..10) }
  end

  context 'testing associations' do
    it { expect(review).to belong_to(:user) }
    it { expect(review).to belong_to(:book) }
  end
end
