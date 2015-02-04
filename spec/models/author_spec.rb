require 'rails_helper'

RSpec.describe Author, :type => :model do
  let(:author) { FactoryGirl.create :author }

  context 'testing validations' do
    it { expect(author).to be_valid }

    it { expect(author).to validate_presence_of(:first_name) }
    it { expect(author).to validate_presence_of(:first_name) }

    it { expect(author).to ensure_length_of(:first_name).is_at_most(30) }
    it { expect(author).to ensure_length_of(:last_name).is_at_most(30) }
    it { expect(author).to ensure_length_of(:description).is_at_most(500) }
  end

  context 'testing associations' do
    it { expect(author).to have_many(:books) }
    it { expect(author).to have_many(:categories).through(:books) }
  end
end
