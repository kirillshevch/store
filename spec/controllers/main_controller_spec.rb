require 'rails_helper'

RSpec.describe MainController, type: :controller do
  let(:book) { FactoryGirl.create(:best_book) }
  let(:order_item) { OrderItem.new }

  describe 'GET #index' do
    before do
      Book.stub(:best_sellers).and_return book
      OrderItem.stub(:new).and_return order_item
    end

    it 'receives best_sellers and return book' do
      expect(Book).to receive(:best_sellers)
      get :index
    end

    it 'assigns @books' do
      get :index
      expect(assigns(:books)).to be(book)
    end

    it 'render :index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'receives new and return new order item' do
      expect(OrderItem).to receive(:new)
      get :index
    end

    it 'assings @orderitem' do
      get :index
      expect(assigns(:orderitem)).to be(order_item)
    end
  end
end