require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) { FactoryGirl.create :user }

  context 'testing validates' do
    it 'is valid with Faker data' do
      expect(user).to be_valid
    end

    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_uniqueness_of(:email) }

    it { expect(user).to validate_presence_of(:password) }

    it { expect(user).to ensure_length_of(:first_name).is_at_most(50) }
    it { expect(user).not_to validate_numericality_of(:first_name) }

    it { expect(user).to ensure_length_of(:last_name).is_at_most(50) }
    it { expect(user).not_to validate_numericality_of(:last_name) }

    it 'is invalid without an email' do
      expect(FactoryGirl.build :user, email: nil).not_to be_valid
    end

    it 'is invalid without an password' do
      expect(FactoryGirl.build :user, password: nil).not_to be_valid
    end

    it 'is valid without an first name' do
      expect(FactoryGirl.build :user, first_name: nil).to be_valid
    end

    it 'is valid without an last name' do
      expect(FactoryGirl.build :user, last_name: nil).to be_valid
    end
  end
end
