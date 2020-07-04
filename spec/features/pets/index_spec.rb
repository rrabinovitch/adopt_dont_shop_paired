require 'rails_helper'

RSpec.describe "visit a pets index page", type: :feature do
  
  it "shows all pet information" do
    
    shelter = Shelter.create(name: "Test Shelter")

    test_pet = Pet.create(
              image: "/app/assets/images/dog_placeholder.png",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: shelter.id
              )
    visit '/pets'
    
    expect(page).to have_content(test_pet.name)
    expect(page).to have_content("Test Shelter")
    
  end
end