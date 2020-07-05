require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  
  it 'I can edit shelter information from the Show page' do
    
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
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
  
  it "I get an 'Edit' link for each shelter in '/shelters'" do
    
    shelter = Shelter.create(name: "Shelter A")

    test_pet = Pet.create(
              image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: shelter.id,
              description: "A loving 3 year old pup looking for a partner to play fetch with!",
              status: "Adoptable"
              )
              
      visit '/shelters'
      click_link "Edit"
      expect(current_path).to eq("/shelters/#{shelter.id}/edit")
      
  end
  
end