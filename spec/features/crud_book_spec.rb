require 'features/features_spec_helper'

feature 'CRUD books' do
  background do
    admin = FactoryGirl.create(:admin)
    @book = FactoryGirl.create(:books)
    login_as admin
  end

  scenario 'create books' do
    visit '/admin/books/new'
    within('#new_book') do
      fill_in 'Title',             with: Faker::Lorem.word
      fill_in 'Short description', with: Faker::Lorem.sentence(4)
      fill_in 'Full description',  with: Faker::Lorem.paragraph(10)
      fill_in 'Price',             with: Faker::Number.number(3)
      click_button 'Save'
    end

    expect(page).to have_content('Book successfully created')
  end

  scenario 'read books' do
    visit "admin/books/#{@book.id}"

    expect(page).to have_content('Details for Book')
    expect(page).to have_content('Title')
    expect(page).to have_content('Short description')
    expect(page).to have_content('Full description')
    expect(page).to have_content('Price')
  end

  scenario 'edit books' do
    visit "admin/books/#{@book.id}/edit"
    within('#edit_book') do
      fill_in 'Title',             with: Faker::Lorem.word
      fill_in 'Short description', with: Faker::Lorem.sentence(4)
      fill_in 'Full description',  with: Faker::Lorem.paragraph(10)
      fill_in 'Price',             with: Faker::Number.number(3)
      click_button 'Save'
    end
    expect(page).to have_content('Book successfully updated')
  end

  scenario 'delete books' do
    visit "admin/books/#{@book.id}/delete"
    click_button 'Yes, I\'m sure'

    expect(page).to have_content('Book successfully deleted')
  end
end