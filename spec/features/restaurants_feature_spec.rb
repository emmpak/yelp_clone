require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit('/restaurants')
      expect(page).to have_content("No restaurants added yet")
      expect(page).to have_link("Add a restaurant")
    end
  end

  context 'restaurants have been added' do
    before { Restaurant.create(name: 'Chipotle') }

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content("Chipotle")
      expect(page).not_to have_content("No restaurants added yet")
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit('/restaurants')
      click_link "Add a restaurant"
      fill_in "Name", with: 'Chipotle'
      click_button "Create Restaurant"
      expect(page).to have_content 'Chipotle'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do
    let!(:chipotle) { Restaurant.create(name: 'Chipotle') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Chipotle'
      expect(page).to have_content 'Chipotle'
      expect(current_path).to eq "/restaurants/#{chipotle.id}"
    end
  end

  context 'updating restaurants' do
    before { Restaurant.create name: 'Chipotle', description: 'Mexican', id: 1 }

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Chipotle'
      fill_in 'Name', with: 'Chipotle'
      fill_in 'Description', with: 'Mexican burrito'
      click_button 'Update Restaurant'
      click_link 'Chipotle'
      expect(page).to have_content 'Chipotle'
      expect(page).to have_content 'Mexican burrito'
      expect(current_path).to eq '/restaurants/1'
    end
  end

  context 'deleteing restaurant' do
    before {Restaurant.create name: 'Chipotle', description: 'Mexican'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Chipotle'
      expect(page).not_to have_content 'Chipotle'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
