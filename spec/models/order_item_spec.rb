require 'rails_helper'

RSpec.describe OrderItem, :type => :model do
  let(:order_item) { FactoryGirl.build_stubbed(:order_item) }

  context 'testing associations' do
    it { expect(order_item).to belong_to(:order) }
    it { expect(order_item).to belong_to(:book) }
    it { expect(order_item).to belong_to(:user) }
  end

  context '.count_price' do
    let(:book) { FactoryGirl.create(:book) }
    let(:order_item_upd) { FactoryGirl.build(:order_item, quantity: 2, book: book) }
    it 'called before save' do
      #expect(order_item_upd).to receive(:count_price)
      #order_item_upd.save
    end
  end
end
