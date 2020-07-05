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
  
  it "I get an 'Delete' link for each shelter in '/shelters" do
    
  visit "/shelters"

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
    click_link "Delete"
    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content("Shelter A")
  end
  
end