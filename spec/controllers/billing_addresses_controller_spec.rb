require 'rails_helper'

RSpec.describe BillingAddressesController, :type => :controller do

  describe 'POST create' do
    let(:user) { FactoryGirl.create(:user) }
    it 'redirects to back'

    context 'with valid attributes' do
      it 'calls create_billing_address for current_user'
    end

    context 'with invalid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub(:create_billing_address).and_return false
      end

      it 'sends error flash' do
        post :create, {}
        expect(flash[:error]).to have_content 'Invalid data'
      end
    end
  end


  describe 'PUT update' do
    it ''
  end

end
