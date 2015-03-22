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
      FactoryGirl.create(:order_item, quantity: 1, book_id: book.id, order_id: order.id)
    end

    scenario 'billing address step' do
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
    end
    # TODO rename all before
    context 'shipping address step' do
      given!(:billing_address) { FactoryGirl.create(:billing_address, country_id: country.id, order_id: order.id, user_id: user.id) }

      scenario 'shipping address step' do
        visit checkout_path(:shipping_address)

        within('#new_checkout_form') do
          fill_in 'First name', with: Faker::Name.first_name
          fill_in 'Last name', with: Faker::Name.last_name
          fill_in 'Address', with: Faker::Address.street_address
          select(country.name)
          fill_in 'City', with: Faker::Address.city
          fill_in 'Zipcode', with: Faker::Address.zip
          fill_in 'Phone', with: Faker::PhoneNumber.cell_phone

          click_button 'Save and continue'
        end

        expect(current_path).to eq(checkout_path(:delivery))
      end
    end

    context 'delivery and payment step' do
      given!(:billing_address) { FactoryGirl.create(:billing_address, country_id: country.id, order_id: order.id, user_id: user.id) }
      given!(:shipping_address) { FactoryGirl.create(:shipping_address, country_id: country.id, order_id: order.id, user_id: user.id) }

      scenario 'delivery step' do
        visit checkout_path(:delivery)

        within('#new_checkout_form') do
          choose('checkout_form[delivery]', match: :first)

          click_button 'Save and continue'
        end

        expect(current_path).to eq(checkout_path(:payment))
      end

      scenario 'payment step' do
        visit checkout_path(:payment)

        within('#new_checkout_form') do
          fill_in 'Number', with: '12345678901234'
          fill_in 'Month', with: 12
          fill_in 'Year', with: Time.now.year
          fill_in 'cvv', with: '111'

          click_button 'Save and continue'
        end

        expect(current_path).to eq(checkout_path(:confirm))
      end
    end

    context 'final step' do
      given!(:billing_address) { FactoryGirl.create(:billing_address, country_id: country.id, order_id: order.id, user_id: user.id) }
      given!(:shipping_address) { FactoryGirl.create(:shipping_address, country_id: country.id, order_id: order.id, user_id: user.id) }
      given!(:credit_card) { FactoryGirl.create(:credit_card, order_id: order.id) }

      scenario 'final step' do
        visit checkout_path(:confirm)

        click_button 'Place order'
        expect(page).to have_content('Go to shop')
      end
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

  context 'User with addresses' do
    background do
      login_as user
      FactoryGirl.create(:order_item, quantity: 1, book_id: book.id, order_id: order.id)
    end

    given!(:billing_address) { FactoryGirl.create(:billing_address, country_id: country.id, order_id: order.id, user_id: user.id) }
    given!(:shipping_address) { FactoryGirl.create(:shipping_address, country_id: country.id, order_id: order.id, user_id: user.id) }

    scenario 'isset billing address' do
      visit checkout_path(:billing_address)

      expect(page).to have_field('First name', with: billing_address.first_name)
    end

    scenario 'isset shipping address' do
      visit checkout_path(:shipping_address)

      expect(page).to have_field('First name', with: shipping_address.first_name)
    end
  end

  context 'No auth user' do

  end
end