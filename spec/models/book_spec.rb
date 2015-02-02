require 'rails_helper'

RSpec.describe Book, :type => :model do

  let(:book) { FactoryGirl.create :book }

  context 'testing validations' do
    it { expect(book).to be_valid }



  end

  context 'testing associations' do
    it 'belongs to author' do
      expect(book).to belong_to(:author)
    end

    it 'belongs to category' do
      expect(book).to belong_to(:category)
    end

    it 'has many ratings' do
      expect(book).to have_many(:ratings)
    end

    it 'has many users' do
      expect(book).to have_many(:users).through(:ratings)
    end

  end
end
