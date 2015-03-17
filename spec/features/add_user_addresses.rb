require 'features/features_spec_helper'

feature 'Create, update addresses' do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:country) { FactoryGirl.create(:country) }

  background do
    login_as user
  end

  context 'create addreses' do
    scenario 'billing address with valid params' do
      visit edit_user_registration_path

      within('#new_billing_address') do
        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Address', with: Faker::Address.street_address
        fill_in 'City', with: Faker::Address.city
        fill_in 'Zipcode', with: Faker::Address.zip
        fill_in 'Phone', with: Faker::PhoneNumber.cell_phone

        click_button 'Save'
      end

      expect(page).to have_content('Success add billing address')
    end

    scenario 'billing address with invalid params' do
      visit edit_user_registration_path

      within('#new_billing_address') do
        fill_in 'First name', with: ''
        fill_in 'Last name', with: ''
        fill_in 'Address', with: ''
        fill_in 'City', with: ''
        fill_in 'Zipcode', with: ''
        fill_in 'Phone', with: ''

        click_button 'Save'
      end

      expect(page).to have_content('Create billing address error')
    end

    scenario 'shipping address with valid params' do

      visit edit_user_registration_path

      within('#new_shipping_address') do
        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Address', with: Faker::Address.street_address
        fill_in 'City', with: Faker::Address.city
        fill_in 'Zipcode', with: Faker::Address.zip
        fill_in 'Phone', with: Faker::PhoneNumber.cell_phone

        click_button 'Save'
      end

      expect(page).to have_content('Success add shipping address')
    end

    scenario 'shipping address with invalid params' do
      visit edit_user_registration_path

      within('#new_shipping_address') do
        fill_in 'First name', with: ''
        fill_in 'Last name', with: ''
        fill_in 'Address', with: ''
        fill_in 'City', with: ''
        fill_in 'Zipcode', with: ''
        fill_in 'Phone', with: ''

        click_button 'Save'
      end

      expect(page).to have_content('Create shipping address error')
    end
  end

  context 'update addreses' do
    scenario 'billing address with valid params' do
      visit edit_user_registration_path

      within('') do
        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Address', with: Faker::Address.street_address
        fill_in 'City', with: Faker::Address.city
        fill_in 'Zipcode', with: Faker::Address.zip
        fill_in 'Phone', with: Faker::PhoneNumber.cell_phone
      end

      expect(page).to have_content('Success update billing address')
    end

    scenario 'billing address with invalid params' do
      visit edit_user_registration_path

      within('') do
        fill_in 'First name', with: ''
        fill_in 'Last name', with: ''
        fill_in 'Address', with: ''
        fill_in 'City', with: ''
        fill_in 'Zipcode', with: ''
        fill_in 'Phone', with: ''
      end

      expect(page).to have_content('Update billing address error')
    end

    scenario 'shipping address with valid params' do
      visit edit_user_registration_path

      within('') do
        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Address', with: Faker::Address.street_address
        fill_in 'City', with: Faker::Address.city
        fill_in 'Zipcode', with: Faker::Address.zip
        fill_in 'Phone', with: Faker::PhoneNumber.cell_phone
      end

      expect(page).to have_content('')
    end

    scenario 'shipping address with invalid params' do
      visit edit_user_registration_path

      within('') do
        fill_in 'First name', with: Faker::Name.first_name
        fill_in 'Last name', with: Faker::Name.last_name
        fill_in 'Address', with: Faker::Address.street_address
        fill_in 'City', with: Faker::Address.city
        fill_in 'Zipcode', with: Faker::Address.zip
        fill_in 'Phone', with: Faker::PhoneNumber.cell_phone
      end

      expect(page).to have_content('')
    end
  end

end