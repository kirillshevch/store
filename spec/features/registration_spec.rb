require 'features/features_spec_helper'

feature 'Registration' do
  scenario 'sign up user' do
    visit new_user_registration_path
    within '#signup' do
      fill_in 'Email',    with: Faker::Internet.email
      fill_in 'Password', with: Faker::Internet.password(8)
      click_button 'Sign up'
    end

    expect(page).not_to have_content('Sign up')
    expect(page).to have_content('Sign out')
    expect(page).to have_content('Authentication success!')
  end
end