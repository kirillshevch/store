require 'features/features_spec_helper'

feature 'Cart' do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:author) { FactoryGirl.create(:author) }
  given!(:category) { FactoryGirl.create(:category) }
  given!(:book) { FactoryGirl.create(:book, author: author, category: category) }
  given!(:book1) { FactoryGirl.create(:book, title: "test", author: author, category: category) }
  given!(:coupon) { FactoryGirl.create(:coupon) }
  given!(:order) { FactoryGirl.create(:order, user_id: user.id) }

  background do
    login_as user
    # todo через factory
    order.order_items.create(quantity: 1, book_id: book.id)
    order.order_items.create(quantity: 1, book_id: book1.id)

    visit cart_path
  end

  scenario 'User visit cart and remove one book from it' do
    expect(page).to have_content("#{book.title}")

    click_link('&times', match: :first)

    expect(page).not_to have_content("#{book.title}")
  end

  scenario 'User visit cart and remove all books from it' do
    expect(page).to have_content("#{book.title}")
    expect(page).to have_content("#{book1.title}")

    click_link('empty cart')

    expect(page).not_to have_content("#{book.title}")
    expect(page).not_to have_content("#{book1.title}")
  end

  scenario 'Continue shopping' do
    click_link('continue shopping')

    expect(current_path).to eq(shop_path)
  end

  scenario 'User visit cart and change quantity book' do

   within first('.form-group') do
      fill_in 'Quantity', with: 5
      click_button 'up'
   end

   expect(page).to  have_content(book.price*5)
  end

  scenario 'User visit cart and error change quantity book' do

    within first('.form-group') do
      fill_in 'Quantity', with: -5
      click_button 'up'
    end

    expect(page).to  have_content('Error update book quantity')
  end

  scenario 'User visit cart and add coupon' do
    fill_in 'Code', with: coupon.code
    click_button('Update')

    expect(page).to have_content("Discount: #{coupon.discount}$")
  end

  scenario 'User visit cart and add undefined coupon' do
    fill_in 'Code', with: 0
    click_button('Update')

    expect(page).to have_content('Undefined coupon')
  end
end