require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'Chipotle' }

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Chipotle'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    click_link 'Chipotle'
    expect(page).to have_content('so so')
    expect(page).to have_content('3')
  end
end
