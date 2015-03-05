require 'features/features_spec_helper'

feature 'Add books to cart' do
  given(:author) { FactoryGirl.create(:author) }
  given(:category) { FactoryGirl.create(:category) }
  given(:book) { FactoryGirl.create(:book, author: author, category: category, best_seller: true) }
  given(:state) { FactoryGirl.create(:state) }
  given(:order) { FactoryGirl.create(:order, state: state) }

  scenario 'A user adds book to cart successfully from book show' do
    visit book_path(book)
    click_button 'Add book to cart'

    expect(page).to have_content('Success add to cart!')
  end

  scenario 'A user adds book to cart from main page' do

    visit root_path
    within('#new_order_item') do
      click_button 'Add book to cart'
    end


    expect(page).to have_content('Success add to cart!')
  end
end