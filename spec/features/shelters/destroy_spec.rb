require 'rails_helper'

RSpec.describe "Delete shelter", type: :feature do
  
  it 'I can delete shelter information from the Show page' do
    
    test_shelter = Shelter.create!(name: "Test Shelter", address: "Test Address", city: "Test City", state: "AK", zip: "99999")
    visit "/shelters/#{test_shelter.id}"

    expect(page).to have_content('Test Shelter')
    
    click_link "Delete Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content('Test Shelter')

  
  end
  
end