require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:category_list) { FactoryGirl.create_list(:category, 3) }
  let!(:category) { FactoryGirl.create(:category) }
  let!(:books_list) { FactoryGirl.create_list(:book, 3, category_id: category.id) }

  describe 'GET #index' do
    before do
      Book.stub_chain(:all, :page).and_return books_list
      Category.stub(:all).and_return category_list
    end

    it 'assigns @books' do
      get :index
      expect(assigns(:books)).to eq(books_list)
    end

    it 'assigns @categories' do
      get :index
      expect(assigns(:categories)).to eq(category_list)
    end

    it 'renders :index template' do
      get :index
      expect(response).to render_template :index
    end

  end

  describe 'GET #show' do
    before do
      Book.stub_chain(:where, :page).and_return books_list
      Category.stub(:find_by).and_return category
      Category.stub(:all).and_return category_list
    end

    it 'assigns @books' do
      get :show, id: category.id
      expect(assigns(:books)).to eq(books_list)
    end

    it 'assigns @category' do
      get :show, id: category.id
      expect(assigns(:category)).to eq(category)
    end

    it 'assigns @categories' do
      get :show, id: category.id
      expect(assigns(:categories)).to eq(category_list)
    end

    it 'renders :show template' do
      get :show, id: category.id
      expect(response).to render_template :show
    end
  end
end