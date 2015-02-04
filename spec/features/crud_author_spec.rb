require 'features/features_spec_helper'

feature 'CRUD author' do
  background do
    admin = FactoryGirl.create(:admin)
    @author = FactoryGirl.create(:author)
    login_as admin
  end

  scenario 'create author' do
    visit '/admin/author/new'
    within('#new_author') do
      fill_in 'First name',             with: Faker::Name.first_name
      fill_in 'Last name',              with: Faker::Name.last_name
      fill_in 'Description',            with: Faker::Lorem.paragraph(10)
      click_button 'Save'
    end

    expect(page).to have_content('Author successfully created')
  end

  scenario 'read author' do
    visit "admin/author/#{@author.id}"

    expect(page).to have_content('First name')
    expect(page).to have_content('Last name')
    expect(page).to have_content('Description')

  end

  scenario 'edit author' do
    visit "admin/author/#{@author.id}/edit"
    within('#edit_author') do
      fill_in 'First name',             with: Faker::Name.first_name
      fill_in 'Last name',              with: Faker::Name.last_name
      fill_in 'Description',            with: Faker::Lorem.paragraph(10)
      click_button 'Save'
    end
    expect(page).to have_content('Author successfully updated')
  end

  scenario 'delete author' do
    visit "admin/author/#{@author.id}/delete"
    click_button 'Yes, I\'m sure'

    expect(page).to have_content('Author successfully deleted')
  end
end