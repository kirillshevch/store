class CreditCardsController < ApplicationController

  def new
    if current_user.credit_card.nil?
      @card = current_user.build_credit_card
    else
      redirect_to edit_credit_card_url(current_user.credit_card.id)
    end
  end

  def create
    card = current_user.build_credit_card(card_params)
    if card.save
      redirect_to confirm_url
    else
      redirect_to :back, alert: "Error create credit card"
    end
  end

  def edit
    if current_user.credit_card.nil?
      redirect_to new_credit_card_url, alert: "Create a credit card before editing"
    else
      @card = current_user.credit_card
      render 'new'
    end
  end

  def update
    card = current_user.credit_card
    if card.update(card_params)
      redirect_to confirm_url
    else
      redirect_to :back, alert: "Invalid attributes"
    end
  end

  private

    def card_params
      params.require(:credit_card).permit(:number, :month, :year, :cvv)
    end
end