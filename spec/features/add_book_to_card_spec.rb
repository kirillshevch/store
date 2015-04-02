require 'features/features_spec_helper'

feature 'Add books to cart' do
  given!(:author) { FactoryGirl.create(:author) }
  given!(:category) { FactoryGirl.create(:category) }
  given!(:book) { FactoryGirl.create(:book, author: author, category: category, best_seller: true) }
  given(:order) { FactoryGirl.create(:order) }

  scenario 'A user adds book to cart successfully from book show' do
    visit book_path(book)
    within('#new_order_item') do
      click_button 'Add book to cart'
    end

    expect(page).to have_content('Success add to cart!')
    expect(page).to have_content("Cart: (1) #{order.price}")
  end

  scenario 'A user adds book with custom quantity to cart successfully from book show' do
    visit book_path(book)
    within('#new_order_item') do
      fill_in 'quantity', with: 5
      click_button 'Add book to cart'
    end

    expect(page).to have_content('Success add to cart!')
    expect(page).to have_content("Cart: (5) #{order.price}")
  end

  scenario 'A user adds book to cart from main page' do
    visit root_path
    within('#new_order_item') do
      click_button 'Add book to cart'
    end

     expect(page).to have_content('Success add to cart!')
  end
end