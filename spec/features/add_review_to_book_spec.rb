require 'features/features_spec_helper'

feature 'Add review for book' do
  given!(:book) { FactoryGirl.create(:book) }

  context 'Login user' do
    given(:user) { FactoryGirl.create(:user) }

    background do
      user = FactoryGirl.create(:user)
      login_as user
    end

    scenario 'User visit review page and add review' do
      visit new_book_review_path(book.id)
      fill_in 'Rating', with: 10
      fill_in 'Short review', with: Faker::Lorem.sentence(4)
      fill_in 'Full review', with: Faker::Lorem.paragraph(4)

      click_button 'Add'

      expect(current_path).to eq(book_path(book.id))
    end

    scenario 'User visit review page and add review with invalid attributes' do
      visit new_book_review_path(book.id)
      fill_in 'Rating', with: 0
      fill_in 'Short review', with: ''
      fill_in 'Full review', with: ''

      click_button 'Add'

      expect(page).to have_content('Error create review')
      expect(current_path).to eq(new_book_review_path(book.id))
    end
  end

  context 'Not login user' do
    given!(:book) { FactoryGirl.create(:book) }

    scenario 'no see link add review' do
      visit book_path(book.id)

      expect(page).not_to have_content('Add review for this book')
    end
  end
end