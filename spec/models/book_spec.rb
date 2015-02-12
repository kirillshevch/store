require 'rails_helper'

RSpec.describe Book, :type => :model do

  let(:books) { FactoryGirl.create :books }

  context 'testing validations' do
    it { expect(book).to be_valid }
    it { expect(book).to validate_presence_of(:title) }
    it { expect(book).to validate_presence_of(:short_description) }
    it { expect(book).to validate_presence_of(:full_description) }

    it { expect(book).to validate_numericality_of(:price)  }

    it { expect(book).to validate_presence_of(:price) }

    it { expect(book).to ensure_length_of(:title).is_at_most(50) }
    it { expect(book).to ensure_length_of(:short_description).is_at_most(150) }
    it { expect(book).to ensure_length_of(:full_description).is_at_most(500) }
  end

  context 'testing associations' do
    it 'belongs to author' do
      expect(book).to belong_to(:author)
    end

    it 'belongs to categories' do
      expect(book).to belong_to(:categories)
    end

    it 'has many ratings' do
      expect(book).to have_many(:ratings)
    end

    it 'has many users' do
      expect(book).to have_many(:users).through(:ratings)
    end
  end
end
