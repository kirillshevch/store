require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { FactoryGirl.create(:book) }
  let(:order_item) { OrderItem.new }

  describe 'GET #show' do
    before do
      Book.stub(:find).and_return book
      OrderItem.stub(:new).and_return order_item
    end

    it 'receives find and return book' do
      expect(Book).to receive(:find).with(book.id.to_s)
      get :show, id: book.id
    end

    it 'assigns @book' do
      get :show, id: book.id
      expect(assigns(:book)).to be(book)
    end

    it 'renders :show template' do
      get :show, id: book.id
      expect(response).to render_template :show
    end

    it 'receives new and return new order item' do
      expect(OrderItem).to receive(:new)
      get :show, id: book.id
    end

    it 'assings @orderitem' do
      get :show, id: book.id
      expect(assigns(:orderitem)).to be(order_item)
    end
  end
end
