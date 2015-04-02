require 'rails_helper'

RSpec.describe OrdersController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:current_order) { FactoryGirl.create(:order, user_id: user.id) }
  let!(:order_list) { FactoryGirl.create_list(:order, 3, user_id: user.id, state: :in_queue) }
  let(:coupon) { FactoryGirl.create(:coupon) }
  let(:order_params) { FactoryGirl.attributes_for(:order, coupon_id: coupon.id) }

  before do
    create_ability!
  end

  describe '#GET index' do
    context 'User login' do
      before do
        controller.stub(:current_user).and_return user
        controller.stub(:current_order).and_return current_order
        user.stub(:orders).and_return order_list
        get :index
      end

      it 'renders :index template' do
        expect(response).to render_template :index
      end

    end

    context 'User not login' do
      before do
        controller.stub(:current_user).and_return nil
        controller.stub(:current_order).and_return current_order
        user.stub(:orders).and_return order_list
        get :index
      end
    end

    context 'cancan doesnt allow :index' do
      before do
        @ability.cannot :index, Order
        get :index
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path(locale: :en))
      end

      it 'sends alert' do
        expect(flash[:alert]).to have_content 'Access denied'
      end
    end
  end

  describe '#GET show' do
    context do
      before do
        Order.stub(:find).and_return current_order
        get :show, id: current_order.id
      end

      it 'rendres :show template' do
        expect(response).to render_template 'show'
      end

      it 'assigns @order' do
        expect(assigns(:order)).to eq(current_order)
      end
    end

    context 'cancan doesnt allow :show' do
      before do
        @ability.cannot :show, Order
        get :show, id: current_order.id
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path(locale: :en))
      end

      it 'sends alert' do
        expect(flash[:alert]).to have_content 'Access denied'
      end
    end
  end

  describe '#PUT update' do
    context 'set coupon' do
      before do
        Coupon.stub(:find_by).and_return coupon
        coupon.stub(:status).and_return true
        Order.stub(:update).and_return true
        put :update, id: current_order.id, order: order_params
      end

      it 'redirects to cart' do
        expect(response).to redirect_to(cart_path(locale: :en))
      end
    end

    context 'coupon undefined' do
      before do
        Coupon.stub(:find_by).and_return false
        put :update, id: current_order.id, order: order_params
      end

      it 'redirects to cart' do
        expect(response).to redirect_to(cart_path(locale: :en))
      end

      it 'sends alert' do
        expect(flash[:alert]).to have_content 'Undefined coupon'
      end
    end

    context 'coupon expired' do
      before do
        Coupon.stub(:find_by).and_return coupon
        coupon.stub(:status).and_return false
        put :update, id: current_order.id, order: order_params
      end

      it 'redirects to cart' do
        expect(response).to redirect_to(cart_path(locale: :en))
      end

      it 'sends alert' do
        expect(flash[:alert]).to have_content 'Coupon expired'
      end
    end
  end
end