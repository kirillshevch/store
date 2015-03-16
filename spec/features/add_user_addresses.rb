require 'features/features_spec_helper'

feature 'Create, update addresses' do
  given!(:user) { FactoryGirl.create(:user) }

  background do
    login_as user
  end

  context 'create addreses' do
    scenario 'billing address with valid params' do



    end

    scenario 'billing address with invalid params' do

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

    end

    scenario 'billing address with invalid params' do

    end

    scenario 'shipping address with valid params' do

    end

    scenario 'shipping address with valid params' do

    end
  end

end