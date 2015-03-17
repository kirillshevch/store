require 'features/features_spec_helper'

feature 'Checkout Wizard' do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:country) { FactoryGirl.create(:country) }
  given!(:author) { FactoryGirl.create(:author) }
  given!(:category) { FactoryGirl.create(:category) }
  given!(:book) { FactoryGirl.create(:book, author: author, category: category) }
  given(:order) { FactoryGirl.create(:order, user_id: user.id) }

  context 'User without addresses and credit card' do
    background do
      login_as user
      order.order_items.create(quantity: 1, book_id: book.id)
    end

    # TODO разбить на шаги
    scenario 'steps with valid params' do
      visit cart_path

      click_link 'checkout'

      expect(current_path).to eq(checkout_path(:billing_address))

      within('#new_checkout_form') do
        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Address', with: Faker::Address.street_address
        fill_in 'City', with: Faker::Address.city
        fill_in 'Zipcode', with: Faker::Address.zip
        fill_in 'Phone', with: Faker::PhoneNumber.cell_phone

        click_button 'Save and continue'
      end

      expect(current_path).to eq(checkout_path(:shipping_address))

      within('#new_checkout_form') do
        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Address', with: Faker::Address.street_address
        fill_in 'City', with: Faker::Address.city
        fill_in 'Zipcode', with: Faker::Address.zip
        fill_in 'Phone', with: Faker::PhoneNumber.cell_phone

        click_button 'Save and continue'
      end

      expect(current_path).to eq(checkout_path(:delivery))


      within('#new_checkout_form') do
        choose('checkout_form[delivery]', match: :first)

        click_button 'Save and continue'
      end

      expect(current_path).to eq(checkout_path(:payment))

      within('#new_checkout_form') do
        fill_in 'Number', with: '12345678901234'
        fill_in 'Month', with: 12
        fill_in 'Year', with: Time.now.year
        fill_in 'cvv', with: '111'

        click_button 'Save and continue'
      end

      expect(current_path).to eq(checkout_path(:confirm))

      click_button 'Place order'

      expect(current_path).to eq(order_path(order.id))

      # TODO expect(current_path).to have_content('Go back to store')
    end

    scenario 'steps with valid params (copyaddress)' do
      visit cart_path

      click_link 'checkout'

      expect(current_path).to eq(checkout_path(:billing_address))

      within('#new_checkout_form') do
        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Address', with: Faker::Address.street_address
        fill_in 'City', with: Faker::Address.city
        fill_in 'Zipcode', with: Faker::Address.zip
        fill_in 'Phone', with: Faker::PhoneNumber.cell_phone
        check('checkout_form[copyaddress]')

        click_button 'Save and continue'
      end

      expect(current_path).to eq(checkout_path(:delivery))
    end

  end

  context 'User with addreses and credit' do

  end

  context 'No auth user' do

  end
end