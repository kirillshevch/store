require 'rails_helper'

RSpec.describe BillingAddressesController, :type => :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:country) { FactoryGirl.create(:country) }
  let!(:address_params) { FactoryGirl.attributes_for(:billing_address, country_id: country.id) }
  let!(:billing_address) { FactoryGirl.build_stubbed(:billing_address, country_id: country.id, user_id: user.id) }

  describe 'POST #create' do

    before do
      request.env['HTTP_REFERER'] = edit_user_registration_path
    end

    context 'with valid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub(:build_billing_address).and_return billing_address
        billing_address.stub(:save).and_return true
      end

      it 'redirects to back' do
        post :create, billing_address: address_params
        expect(response).to redirect_to(edit_user_registration_path)
      end
    end

    context 'with invalid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub(:build_billing_address).and_return billing_address
        billing_address.stub(:save).and_return false
      end

      it 'redirects to back' do
        post :create, billing_address: address_params
        expect(response).to redirect_to(edit_user_registration_path)
      end

      it 'sends alert' do
        post :create, billing_address: address_params
        expect(flash[:alert]).to have_content 'Create billing address error'
      end
    end
  end

  describe 'PUT #update' do

    before do
      request.env['HTTP_REFERER'] = edit_user_registration_path
    end

    context 'with valid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub(:billing_address).and_return billing_address
        billing_address.stub(:update).and_return true
      end

      it 'redirects to back' do
        put :update, id: billing_address.id, billing_address: address_params
        expect(response).to redirect_to(edit_user_registration_path)
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
        expect(response).to redirect_to(edit_user_registration_path)
      end

      it 'sends alert' do
        expect(flash[:alert]).to eq('Update billing address error')
      end
    end
  end

end
