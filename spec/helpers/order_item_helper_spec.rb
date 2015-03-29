require 'rails_helper'

RSpec.describe OrderItemHelper, type: :helper do
  let(:order) { FactoryGirl.create(:order) }

  describe '#cart_status' do
    before do
      create_ability!

      #.stub(:current_order).and_return order
    end

    it 'returns the cart status' do
      expect(helper.cart_status).to eq('empty')
    end
  end
end
