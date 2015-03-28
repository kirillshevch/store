require 'rails_helper'

RSpec.describe BillingAddressesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:address_params) { FactoryGirl.attributes_for(:billing_address).stringify_keys }
  let(:billing_address) { FactoryGirl.build_stubbed(:billing_address) }

  before do
    create_ability!
    controller.stub(:current_user).and_return user
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      before do
        billing_address.stub(:save).and_return true
      end

      it 'redirects to back' do
        post :create, billing_address: address_params
        expect(response).to redirect_to('/users/edit?locale=en')
      end
    end

    context 'with invalid attributes' do
      before do
        billing_address.stub(:save).and_return false
      end

      it 'redirects to back' do
        post :create, billing_address: address_params
        expect(response).to redirect_to('/users/edit?locale=en')
      end

      it 'sends alert' do
        post :create, billing_address: address_params
        expect(flash[:alert]).to have_content 'Create billing address error'
      end
    end

    context 'cancan doesnt allow :create' do
      before do
        @ability.cannot :create, BillingAddress
        post :create, billing_address: address_params
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
        user.stub(:billing_address).and_return billing_address
        billing_address.stub(:update).and_return true
      end

      it 'redirects to back' do
        put :update, id: billing_address.id, billing_address: address_params
        expect(response).to redirect_to('/users/edit?locale=en')
      end
    end

    context 'with invalid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub(:billing_address).and_return billing_address
        billing_address.stub(:update).and_return false
        put :update, id: billing_address.id, billing_address: address_params
      end

      it 'redirects to back' do
        expect(response).to redirect_to('/users/edit?locale=en')
      end

      it 'sends alert' do
        expect(flash[:alert]).to eq('Update billing address error')
      end
    end

    context 'cancan doesnt allow :update' do
      before do
        @ability.cannot :update, BillingAddress
        put :update, id: billing_address.id, billing_address: address_params
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
