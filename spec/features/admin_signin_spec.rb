require 'features/features_spec_helper'

feature 'Rails admin' do

  background do
    admin = FactoryGirl.create(:admin)
    login_as admin
  end

  scenario 'Access to admin panel' do
    visit rails_admin_path

    expect(page).to have_content('Admin')
    expect(page).to have_content('Site Administration')
  end

end