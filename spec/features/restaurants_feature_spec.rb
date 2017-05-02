require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit('/restaurants')
      expect(page).to have_content("No restaurants added yet")
      expect(page).to have_link("Add z restaurant")
    end
  end
end
