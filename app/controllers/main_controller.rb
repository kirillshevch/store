class MainController < ApplicationController
  def index
    @books = Book.best_sellers
    @orderitem = OrderItem.new
  end
end
