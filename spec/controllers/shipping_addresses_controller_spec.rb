require 'rails_helper'

RSpec.describe ShippingAddressesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:address_params) { FactoryGirl.attributes_for(:shipping_address).stringify_keys }
  let(:shipping_address) { FactoryGirl.build_stubbed(:shipping_address) }

  before do
    create_ability!
    controller.stub(:current_user).and_return user
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      before do
        shipping_address.stub(:save).and_return true
      end

      it 'redirects to back' do
        post :create, shipping_address: address_params
        expect(response).to redirect_to('/users/edit?locale=en')
      end
    end

    context 'with invalid attributes' do
      before do
        shipping_address.stub(:save).and_return false
      end

      it 'redirects to back' do
        post :create, shipping_address: address_params
        expect(response).to redirect_to('/users/edit?locale=en')
      end

      it 'sends alert' do
        post :create, shipping_address: address_params
        expect(flash[:alert]).to have_content 'Create shipping address error'
      end
    end

    context 'cancan doesnt allow :create' do
      before do
        @ability.cannot :create, ShippingAddress
        post :create, shipping_address: address_params
      end

      it 'redirect to main page' do
        expect(response).to redirect_to('/?locale=en')
      end

      it 'sends flash error' do
        expect(flash[:alert]).to have_content 'Access denied'
      end
    end
  end


  describe 'PUT #update' do

    context 'with valid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub(:shipping_address).and_return shipping_address
        shipping_address.stub(:update).and_return true
      end

      it 'redirects to back' do
        put :update, id: shipping_address.id, shipping_address: address_params
        expect(response).to redirect_to('/users/edit?locale=en')
      end
    end

    context 'with invalid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub(:shipping_address).and_return shipping_address
        shipping_address.stub(:update).and_return false
        put :update, id: shipping_address.id, shipping_address: address_params
      end

      it 'redirects to back' do
        expect(response).to redirect_to('/users/edit?locale=en')
      end

      it 'sends alert' do
        expect(flash[:alert]).to eq('Update shipping address error')
      end
    end

    context 'cancan doesnt allow :update' do
      before do
        @ability.cannot :update, ShippingAddress
        put :update, id: shipping_address.id, shipping_address: address_params
      end

      it 'redirect to main page' do
        expect(response).to redirect_to('/?locale=en')
      end

      it 'sends flash error' do
        expect(flash[:alert]).to have_content 'Access denied'
      end
    end
  end

end
