class CreditCardsController < ApplicationController

  def new
    if current_user.credit_card.nil?
      @card = current_user.build_credit_card
    else
      redirect_to edit_credit_card_url(current_user.credit_card.id)
    end
  end

  def create
    # TODO что-то не так
    if current_user.create_credit_card(card_params)
      redirect_to confirm_url
    else
      redirect_to :back, alert: "Error create credit card"
    end
  end

  def edit
    @card = current_user.credit_card
    render 'new'
  end

  def update
    current_user.credit_card.update(card_params)
    redirect_to confirm_url
  end

  private

    def card_params
      params.require(:credit_card).permit(:number, :month, :year, :cvv)
    end
end