require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  
  it "I can see all pets by shelter" do

    shelter1 = Shelter.create(name: "Shelter A")
    shelter2 = Shelter.create(name: "Shelter B")

    test_pet1 = Pet.create(
              image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: shelter2.id
              )
              
    test_pet2 = Pet.create(
              image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
              name: "Bella",
              approximate_age: "13",
              sex: "Female",
              shelter_id: shelter2.id
              )
              
    visit "/shelters/#{shelter2.id}/pets"
    expect(page).to have_content("Name: Bella")
    expect(page).to have_content("Age: 13")
    expect(page).to have_content("Sex: Female")
    
  end
end
