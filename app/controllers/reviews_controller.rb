class ReviewsController < ApplicationController
  def new
    if current_user
      @book = Book.find(params[:book_id])
      @review = @book.reviews.new
    else
      redirect_to new_user_session_path, alert: "Sign in before add review"
    end
  end

  def create
    review = current_user.reviews.build(review_params)
    if review.save
      redirect_to book_url(review_params[:book_id])
    else
      redirect_to :back, alert: "Error create review"
    end
  end

  private

    def review_params
      params.require(:review).permit(:number, :title, :text, :book_id)
    end
end
