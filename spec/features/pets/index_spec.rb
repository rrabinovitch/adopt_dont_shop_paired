require 'rails_helper'

RSpec.describe "visit a pets index page", type: :feature do
  
  it "shows all pet information" do
    
    test_shelter = Shelter.create!({
              name: "Test Shelter",
              address: "Test Address",
              city: "Test City",
              state: "AK",
              zip: "99999"})
              
    test_pet = Pet.create!({
              image: "/app/assets/images/dog_placeholder.png",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter: test_shelter
              })
    
    visit '/pets'
    
    expect(page).to have_content(test_pet.name)
    
  end
end