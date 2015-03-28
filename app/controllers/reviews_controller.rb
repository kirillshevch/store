class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new
    authorize! :new, @review
  end

  def create
    review = current_user.reviews.build(review_params)
    authorize! :create, review
    if review.save
      redirect_to book_url(review_params[:book_id])
    else
      redirect_to :back, alert: t('reviews.create_error')
    end
  end

  private

    def review_params
      params.require(:review).permit(:number, :title, :text, :book_id)
    end
end