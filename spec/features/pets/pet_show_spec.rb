require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  
  it "When I visit '/pets/:id' then I see that pet's info" do
    
    shelter1 = Shelter.create(name: "Shelter A")

    test_pet1 = Pet.create(
              image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: shelter1.id
              )
          
              binding.pry
    visit "/pets/#{test_pet1.id}/"
    
    expect(page).to have_content("Name: Bella")
    expect(page).to have_content("Age: 13")
    expect(page).to have_content("Sex: Female")
    # save_and_open_page
  end
end