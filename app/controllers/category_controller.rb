class CategoryController < ApplicationController
  def index
    @books = Book.all
    @categories = Category.all
  end

  def show
    @books = Book.where(category_id: params[:id])
    @category = Category.find_by(id: params[:id])
    @categories = Category.all
  end
end
