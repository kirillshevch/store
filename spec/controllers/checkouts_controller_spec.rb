require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order, user_id: user.id) }
  let(:order_item) { FactoryGirl.create(:order_item, order_id: order.id) }
  let(:access) { Access.new(user, order, :example_step) }

  describe 'GET #show' do
    context 'allow access' do
      before do
        Access.stub(:new).and_return access
        access.stub(:step_access?).and_return true
      end

      context 'billing address step' do
        it 'renders :billing_address template' do
          get :show, id: :billing_address
          expect(response).to render_template :billing_address
        end
      end

      context 'shipping address step' do
        it 'renders :shipping_address template' do
          get :show, id: 'shipping_address'
          expect(response).to render_template :shipping_address
        end
      end

      context 'delivery step' do
        it 'renders :delivery template' do
          get :show, id: 'delivery'
          expect(response).to render_template :delivery
        end
      end

      context 'payment step' do
        it 'renders :payment template' do
          get :show, id: 'payment'
          expect(response).to render_template :payment
        end
      end

      context 'confirm step' do
        it 'renders :confirm template' do
          get :show, id: 'confirm'
          expect(response).to render_template :confirm
        end
      end
    end

    context 'access denied' do
      before do
        Access.stub(:new).and_return access
        access.stub(:step_access?).and_return false
      end

      context 'billing address' do
        before do
          access.stub(:redirect_url).and_return shop_path
          access.stub(:error_text).and_return 'Select book before checkout'
          get :show, id: :billing_address
        end

        it 'redirects to shop page' do
          expect(response).to redirect_to(shop_path)
        end

        it 'sends alert' do
          expect(flash[:alert]).to have_content('Select book before checkout')
        end
      end

      context 'shipping address' do
        before do
          access.stub(:redirect_url).and_return checkout_path(:billing_address)
          access.stub(:error_text).and_return 'Specify the billing address'
          get :show, id: :shipping_address
        end

        it 'redirects billing address step' do
          expect(response).to redirect_to(checkout_path(:billing_address))
        end

        it 'sends alert' do
          expect(flash[:alert]).to have_content('Specify the billing address')
        end
      end

      context 'delivery' do
        before do
          access.stub(:redirect_url).and_return checkout_path(:shipping_address)
          access.stub(:error_text).and_return 'Specify the shipping address'
          get :show, id: :shipping_address
        end

        it 'redirects shipping address step' do
          expect(response).to redirect_to(checkout_path(:shipping_address))
        end

        it 'sends alert' do
          expect(flash[:alert]).to have_content('Specify the shipping address')
        end
      end

      context 'payment' do
        before do
          access.stub(:redirect_url).and_return checkout_path(:delivery)
          access.stub(:error_text).and_return 'Select a delivery method'
          get :show, id: :shipping_address
        end

        it 'redirects delivery step' do
          expect(response).to redirect_to(checkout_path(:delivery))
        end

        it 'sends alert' do
          expect(flash[:alert]).to have_content('Select a delivery method')
        end
      end

      context 'confirm' do
        before do
          access.stub(:redirect_url).and_return checkout_path(:payment)
          access.stub(:error_text).and_return 'Specify the credit card'
          get :show, id: :shipping_address
        end

        it 'redirects payment step' do
          expect(response).to redirect_to(checkout_path(:payment))
        end

        it 'sends alert' do
          expect(flash[:alert]).to have_content('Specify the credit card')
        end
      end
    end
  end

  describe 'PUT #update' do

  end
end