class ReviewsController < ApplicationController
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_registration_url, alert: "Sign up before add review"
  end

  def new
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new
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
