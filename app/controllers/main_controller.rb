class MainController < ApplicationController
  def index
    @books = Book.best_sellers
  end
end
