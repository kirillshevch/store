require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:order_item_params) { FactoryGirl.attributes_for(:order_item).stringify_keys }
  let(:order_item) { FactoryGirl.create(:order_item) }
  let(:order) { FactoryGirl.create(:order) }

  before do
    create_ability!
  end

  describe 'GET #index' do
    context 'cart page' do
      before do
        order.stub_chain(:count_price, :save).and_return true
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
  end

  describe 'POST #create' do
    before do
      request.env['HTTP_REFERER'] = root_path
      controller.stub(:current_order).and_return order
    end

    context 'valid params' do
      before do
        order.stub_chain(:order_items, :build, :save).and_return true
        order.stub_chain(:count_price, :save).and_return true
        post :create, order_item: order_item_params
      end

      it 'redirects to back' do
        expect(response).to redirect_to(root_path)
      end

      it 'sends success' do
        expect(flash[:success]).to have_content 'Success add to cart!'
      end
    end
    context 'invalid params' do
      before do
        order.stub_chain(:order_items, :build, :save).and_return false
        order.stub_chain(:count_price, :save).and_return true
        post :create, order_item: order_item_params
      end

      it 'redirects to back' do
        expect(response).to redirect_to(root_path)
      end

      it 'sends alert' do
        expect(flash[:alert]).to have_content 'Error add to cart'
      end
    end

    context 'cancan doesnt allow :create' do
      before do
        @ability.cannot :create, OrderItem
        post :create, order_item: order_item_params
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path(locale: :en))
      end

      it 'sends alert' do
        expect(flash[:alert]).to have_content 'Access denied'
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        controller.stub(:current_order).and_return order
        order.stub_chain(:order_items, :find).and_return order_item
        order_item.stub(:update_attributes).and_return true
        order.stub_chain(:count_price, :save).and_return true
        request.env['HTTP_REFERER'] = root_path
      end

      it 'redirect to back' do
        put :update, id: order_item.id, order_item: order_item_params
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      before do
        request.env['HTTP_REFERER'] = root_path
        controller.stub(:current_order).and_return order
        order.stub_chain(:order_items, :find).and_return order_item
        order.stub_chain(:count_price, :save).and_return false
        order_item.stub(:update_attributes).and_return false
        put :update, id: order_item.id, order_item: order_item_params

      end

      it 'redirect to back' do
        expect(response).to redirect_to(root_path)
      end

      it 'sends alert' do
        expect(flash[:alert]).to have_content 'Error update book quantity'
      end
    end

    context 'cancan doesnt allow :create' do
      before do
        @ability.cannot :update, OrderItem
        put :update, id: order_item.id, order_item: order_item_params
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path(locale: :en))
      end

      it 'sends alert' do
        expect(flash[:alert]).to have_content 'Access denied'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'delete all items from cart' do
      before do
        controller.stub(:current_order).and_return order
        order.stub_chain(:order_items, :delete).and_return true
        order.stub_chain(:count_price, :save).and_return true
      end

      it 'redirects to back' do
        delete :destroy, id: :all
        expect(response).to redirect_to(cart_path(locale: :en))
      end
    end

    context 'delete item from cart' do
      before do
        controller.stub(:current_order).and_return order
        order.stub_chain(:order_items, :delete).and_return true
        order.stub_chain(:count_price, :save).and_return true
      end

      it 'redirects to back' do
        delete :destroy, id: order_item.id
        expect(response).to redirect_to(cart_path(locale: :en))
      end
    end
  end
end