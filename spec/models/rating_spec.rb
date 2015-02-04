require 'rails_helper'

RSpec.describe Rating, :type => :model do

  let(:rating) { FactoryGirl.create :rating }

  context 'testing validations' do
    it { expect(rating).to validate_presence_of(:number) }
    it { expect(rating).to validate_presence_of(:user_id) }
    it { expect(rating).to validate_presence_of(:book_id) }

    it { expect(rating).to validate_numericality_of(:number) }

    it { expect(rating).to validate_inclusion_of(:number).in_range(1..10) }
  end

  context 'testing associations' do
    it { expect(rating).to belong_to(:user) }
    it { expect(rating).to belong_to(:book) }
  end
end
