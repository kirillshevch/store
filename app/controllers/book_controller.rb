class BookController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @orderitem = OrderItem.new
  end
end
