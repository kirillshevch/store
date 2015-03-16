require 'features/features_spec_helper'

feature 'Shop spec' do
  given!(:author) { FactoryGirl.create(:author) }
  given!(:category) { FactoryGirl.create(:category) }
  given!(:book) { FactoryGirl.create(:book, author: author, category: category) }


  scenario 'user is able to view books' do
    visit shop_path

    find_link("#{book.title}").visible?
    expect(page).to have_content("#{book.title}")
    expect(page).to have_content("#{book.price}")
  end

  scenario 'user is able to view categories' do
    visit shop_path

    find_link("#{category.name}").visible?
    expect(page).to have_content('Shop by categories')
  end

  scenario 'user is able to view books of the category' do
    visit shop_path

    click_link("#{category.name}")
    expect(current_path).to eq(category_path(category))

    expect(page).to have_content("Categories - #{category.name}")
    find_link("#{book.title}").visible?
    expect(page).to have_content("#{book.title}")
    expect(page).to have_content("#{book.price}")
    expect(page).to have_content('Shop by categories')
  end
end