require 'rails_helper'

RSpec.describe Category, :type => :model do

  let(:categories) { FactoryGirl.create :categories }

  context 'testing validations' do

    it { expect(category).to be_valid }
    it { expect(category).to ensure_length_of(:name).is_at_most(50) }
    it { expect(category).to validate_presence_of(:name) }
  end

  context 'testing associations' do
    it { expect(category).to have_many(:books) }
    it { expect(category).to have_many(:authors).through(:books) }
  end
end
