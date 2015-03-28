require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:review_params) { FactoryGirl.attributes_for(:review).stringify_keys }
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }
  let(:review) { FactoryGirl.build_stubbed(:review, user_id: user.id, book_id: book.id) }
  let(:new_review) { Review.new(user_id: user.id, book_id: book.id) }

  before do
    create_ability!
  end

  describe 'GET #new' do
    before do
      Book.stub(:find).and_return book
      book.stub_chain(:reviews, :new).and_return new_review
      get :new, book_id: book.id
    end

    it 'render :new template' do
      expect(response).to render_template :new
    end

    it 'assigns @book' do
      expect(assigns(:book)).to be(book)
    end

    it 'assigns @review' do
      expect(assigns(:review)).to be(new_review)
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub_chain(:reviews, :build).and_return new_review
        review.stub(:save).and_return true
        request.env['HTTP_REFERER'] = book_path(book.id)
      end

      it 'redirect to book url' do
        post :create, book_id: book.id, review: review_params
        expect(response).to redirect_to(book_path(book.id))
      end
    end

    context 'with invalid attributes' do
      before do
        controller.stub(:current_user).and_return user
        user.stub_chain(:reviews, :build).and_return new_review
        review.stub(:save).and_return false
        request.env['HTTP_REFERER'] = new_book_review_path(book.id)
        post :create, book_id: book.id, review: review_params
      end

      it 'redirect to back' do
        expect(response).to redirect_to(new_book_review_path(book.id))
      end

      it 'sends alert' do
        expect(flash[:alert]).to eq('Error create review')
      end
    end

  end

end