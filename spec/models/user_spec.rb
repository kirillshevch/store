require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) { FactoryGirl.create :user }

  context 'testing validates' do
    it 'is valid with Faker data' do
      expect(user).to be_valid
    end

    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email) }

    it { expect(user).to ensure_length_of(:first_name).is_at_most(50) }
    it { expect(user).not_to validate_numericality_of(:first_name) }

    it { expect(user).to ensure_length_of(:last_name).is_at_most(50) }
    it { expect(user).not_to validate_numericality_of(:last_name) }
  end

  context 'testing associations' do
    it { expect(user).to have_many(:reviews) }
  end
end
