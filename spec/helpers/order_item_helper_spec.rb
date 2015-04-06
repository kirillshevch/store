require 'rails_helper'

RSpec.describe OrderItemHelper, type: :helper do

  describe '#cart_status' do

    helper do
      def current_order
        FactoryGirl.create(:order)
      end
    end

    let(:order_items_list) { FactoryGirl.create_list(:order_item, 5, order_id: current_order.id) }

    it 'returns the cart status empty' do
      expect(helper.cart_status).to eq('empty')
    end

    # todo
    context '' do
      before do
        current_order.stub_chain(:order_items, :count).and_return 5
        current_order.stub_chain(:order_items).and_return order_items_list
      end

      it 'returns the cart status with items' do
        expect(helper.cart_status).not_to eq('empty')
      end
    end

  end
end
