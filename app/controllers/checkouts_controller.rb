class CheckoutsController < ApplicationController
  include Wicked::Wizard
  steps :address, :shipping_address, :delivery, :payment, :confirm, :complete

  def show
    render_wizard
  end

  def update

  end
end
