require 'rails_helper'

RSpec.describe "Update shelter", type: :feature do
  
  it 'I can edit shelter information from the Show page' do
    
    test_shelter = Shelter.create!(name: "Test Shelter", address: "Test Address", city: "Test City", state: "AK", zip: "99999")
    visit "/shelters/#{test_shelter.id}"

    click_link "Update Shelter"

    expect(current_path).to eq("/shelters/#{test_shelter.id}/edit")

    fill_in 'Name', with: 'Test Shelter'
    fill_in 'Address', with: '123 Rocky Rd.'
    fill_in 'City', with: 'Boulder'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '81443'
    click_on 'Update Shelter'

    expect(current_path).to eq("/shelters/#{test_shelter.id}")
    expect(page).to have_content('Test Shelter')
    expect(page).to have_content('123 Rocky Rd.')
    expect(page).to have_content('Boulder')
    expect(page).to have_content('CO')
    expect(page).to have_content('81443')
    
  end
  
end