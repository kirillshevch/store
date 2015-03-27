require 'rails_helper'

RSpec.describe ShippingAddressesController, :type => :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:country) { FactoryGirl.create(:country) }
  let!(:shipping_address) { FactoryGirl.build_stubbed(:shipping_address, country_id: country.id, user_id: user.id) }
  let!(:address_params) { FactoryGirl.attributes_for(:shipping_address, country_id: country.id) }

  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub(:current_ability).and_return(@ability)
  end

  describe 'POST #create' do

    before do
      @ability.can :create, ShippingAddress
      request.env['HTTP_REFERER'] = edit_user_registration_path
    end

    context 'with valid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub(:build_shipping_address).and_return shipping_address
        shipping_address.stub(:save).and_return true
      end

      it 'redirects to back' do
        post :create, shipping_address: address_params
        expect(response).to redirect_to(edit_user_registration_path)
      end
    end

    context 'with invalid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub(:build_shipping_address).and_return shipping_address
        shipping_address.stub(:save).and_return false
      end

      it 'redirects to back' do
        post :create, shipping_address: address_params
        expect(response).to redirect_to(edit_user_registration_path)
      end

      it 'sends alert' do
        post :create, shipping_address: address_params
        expect(flash[:alert]).to have_content 'Create shipping address error'
      end
    end
  end

  describe 'PUT #update' do
    let!(:shipping) { FactoryGirl.create(:shipping_address, country_id: country.id, user_id: user.id) }

    before do
      @ability.can :update, ShippingAddress
      request.env['HTTP_REFERER'] = edit_user_registration_path
    end

    context 'with valid attributes' do

      before do
        controller.stub(:current_user).and_return user
        user.stub(:shipping_address).and_return shipping
        shipping.stub(:update).and_return true
      end

      it 'redirects to back' do
        put :update, id: shipping.id, shipping_address: address_params
        expect(response).to redirect_to(edit_user_registration_path)
      end
    end

    context 'with invalid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub(:shipping_address).and_return shipping
        shipping.stub(:update).and_return false
        put :update, id: shipping.id, shipping_address: address_params
      end

      it 'redirects to back' do
        expect(response).to redirect_to(edit_user_registration_path)
      end

      it 'sends alert' do
        expect(flash[:alert]).to eq('Update shipping address error')
      end
    end
  end
end
