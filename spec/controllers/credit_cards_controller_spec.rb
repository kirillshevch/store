require 'rails_helper'

RSpec.describe CreditCardsController, :type => :controller do
  let(:card_params) { FactoryGirl.attributes_for(:credit_card).stringify_keys }
  let(:credit_card) { FactoryGirl.build_stubbed(:credit_card) }
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #new' do
    context 'hasn\'t a credit card' do
      let(:build_credit_card) { CreditCard.new(user: user) }

      before do
        controller.stub(:current_user).and_return user
        user.stub_chain(:credit_card, :nil?).and_return true
        user.stub(:build_credit_card).and_return build_credit_card
      end

      it 'receives build credit card and return build card' do
        expect(user).to receive(:build_credit_card)
        get :new
      end

      it 'render :new template' do
        get :new
        expect(response).to render_template :new
      end

      it 'assigns @card' do
        get :new
        expect(assigns(:card)).to be(build_credit_card)
      end
    end

    context 'has a credit card' do
      before do
        controller.stub(:current_user).and_return user
        user.stub_chain(:credit_card, :nil?).and_return false
        user.stub_chain(:credit_card, :id).and_return credit_card.id
      end

      it 'redirects to edit' do
        get :new
        expect(response).to redirect_to(edit_credit_card_path(credit_card.id))
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub_chain(:build_credit_card, :save).and_return true
      end

      it 'redirects to confrim' do
        post :create, credit_card: card_params
        expect(response).to redirect_to(confirm_path)
      end
    end

    context 'with invalid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub_chain(:build_credit_card, :save).and_return false
        request.env['HTTP_REFERER'] = new_credit_card_path
        post :create, credit_card: card_params
      end

      it 'redirects to back' do
        expect(response).to redirect_to(new_credit_card_path)
      end

      it 'sends alert' do
        expect(flash[:alert]).to eq 'Error create credit card'
      end
    end
  end

  describe 'GET #edit' do
    context 'hasn\'t a credit card' do
      before do
        controller.stub(:current_user).and_return user
        user.stub_chain(:credit_card, :nil?).and_return true
        get :edit, id: credit_card.id
      end

      it 'redirect to new_credit_card_url' do
        expect(response).to redirect_to new_credit_card_path
      end

      it 'sends alert' do
        expect(flash[:alert]).to eq 'Create a credit card before editing'
      end
    end

    context 'has a credit card' do
      before do
        controller.stub(:current_user).and_return user
        user.stub_chain(:credit_card, :nil?).and_return false
        get :edit, id: credit_card.id
      end

      it 'render :new template' do
        expect(response).to render_template :new
      end

      it 'assigns @card' do
        expect(assigns(:card)).not_to be_nil
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub_chain(:credit_card, :update).and_return true
      end

      it 'redirect to confirm url' do
        put :update, id: credit_card.id, credit_card: card_params
        expect(response).to redirect_to(confirm_path)
      end
    end

    context 'with invalid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub_chain(:credit_card, :update).and_return false
        request.env['HTTP_REFERER'] = edit_credit_card_path(credit_card.id)
        put :update, id: credit_card.id, credit_card: card_params
      end

      it 'redirect to back' do
        expect(response).to redirect_to(edit_credit_card_path(credit_card.id))
      end

      it 'sends alert' do
        expect(flash[:alert]).to eq 'Invalid attributes'
      end
    end
  end
end