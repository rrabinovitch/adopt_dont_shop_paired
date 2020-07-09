require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do

  it 'When I visit a Pet Show page I see a link to Delete Pet' do
    @shelter = Shelter.create(name: "Shelter A")

    @pet = Pet.create(
              image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: @shelter.id,
              description: "A loving 3 year old pup looking for a partner to play fetch with!",
              status: "Adoptable"
              )

    visit "/pets/#{@pet.id}"
    
    expect(page).to have_content("Delete Pet")
    click_link "Delete Pet"
    expect(current_path).to eq("/pets/")
  end

  it 'When I visit a Pet Index page I see a link to delete each individual pet' do
    @shelter = Shelter.create(name: "Shelter A")

    @pet = Pet.create(
              image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: @shelter.id,
              description: "A loving 3 year old pup looking for a partner to play fetch with!",
              status: "Adoptable"
              )

    visit "/pets/"

    expect(page).to have_content("Delete Pet")
    click_link "Delete Pet"
    expect(current_path).to eq("/pets/")
    expect(page).to_not have_content("Bailey")
  end
end
