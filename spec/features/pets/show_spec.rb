require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  
  it "When I visit '/pets/:id' then I see that pet's info" do
    
    shelter1 = Shelter.create(name: "Shelter A")

    test_pet1 = Pet.create(
              image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: shelter1.id,
              description: "A loving 3 year old pup looking for a partner to play fetch with!",
              status: "Adoptable"
              )
          
    visit "/pets/#{test_pet1.id}/"
    
    expect(page).to have_content("Name: Bailey")
    expect(page).to have_content("Description: A loving 3 year old pup looking for a partner to play fetch with!")
    expect(page).to have_content("Aproximate Age: 3")
    expect(page).to have_content("Sex: Female")
    expect(page).to have_content("Adoption Status: Adoptable")
  end
    
end