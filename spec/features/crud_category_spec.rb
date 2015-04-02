require 'features/features_spec_helper'

feature 'CRUD categories' do
  background do
    admin = FactoryGirl.create(:admin)
    @category = FactoryGirl.create(:category)
    login_as admin
  end

  scenario 'create categories' do
    visit '/admin/category/new'
    within('#new_category') do
      fill_in      'Name', with: Faker::Lorem.word
      click_button 'Save'
    end

    expect(page).to have_content('Category successfully created')
  end

  scenario 'read categories' do
    visit "admin/category/#{@category.id}"

    expect(page).to have_content('Name')
  end

  scenario 'edit categories' do
    visit "admin/category/#{@category.id}/edit"
    within('#edit_category') do
      fill_in      'Name', with: Faker::Lorem.word
      click_button 'Save'
    end
    expect(page).to have_content('Category successfully updated')
  end

  scenario 'delete categories' do
    visit "admin/category/#{@category.id}/delete"
    click_button 'Yes, I\'m sure'

    expect(page).to have_content('Category successfully deleted')
  end
end