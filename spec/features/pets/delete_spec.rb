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
  
  it "I cannot delete a pet if it has pending pet applications at shelters" do

  test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
  pet1 = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: test_shelter.id, status: "Adoptable")
  pet2 = Pet.create!(name: "Buddy", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "3", sex: "Female", shelter_id: test_shelter.id, status: "Adoptable")
  adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
  PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet1.id, status: "Pending")
  PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet2.id, status: "Pending")
  
  visit "/adoption_applications/#{adoption_application.id}"

  click_on "Approve application for #{pet1.name}"
  expect(current_path).to eq("/pets/#{pet1.id}")
  expect(page).to have_content("Adoption Status: Pending")

  click_link "Delete"
  
  expect(current_path).to eq("/pets/#{pet1.id}")
  expect(page).to have_content("Unable to delete #{pet1.name} because it has an approved application")

  end
end
