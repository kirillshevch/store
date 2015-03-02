require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:order_item_params) { FactoryGirl.attributes_for(:order_item).stringify_keys }
  let(:order_item) { FactoryGirl.build_stubbed(:order_item) }
  let(:order) { FactoryGirl.create(:order) }

  describe 'GET #index' do
    before do
      controller.stub(:current_order).and_return order
      order.stub(:order_items).and_return order_item
      get :index
    end

    it 'assigns @items' do
      expect(assigns(:items)).to be(order_item)
    end

    it 'render :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        controller.stub(:current_order).and_return order
        order.stub_chain(:order_items, :find).and_return order_item
        order_item.stub(:update_attributes).and_return true
        request.env['HTTP_REFERER'] = root_path
      end

      it 'redirect to back' do
        put :update, id: order_item.id, order_item: order_item_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      before do
        controller.stub(:current_order).and_return order
        order.stub_chain(:order_items, :find).and_return order_item
        order_item.stub(:update_attributes).and_return false
        request.env['HTTP_REFERER'] = root_path
      end

      it 'redirect to back' do
        #put :update, id: order_item.id, order_item: order_item_params
        #expect(response).to redirect_to(root_path)
      end

      it 'sends alert' do
        #put :update, id: order_item.id, order_item: order_item_params
        #expect(flash['alert']).to eq('Error update book quantity')
      end
    end
  end

  describe 'DELETE #destroy' do

  end
end