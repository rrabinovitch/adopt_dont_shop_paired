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
  
  it "When I delete shelters it deletes its reviews" do
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
    shelter_review = ShelterReview.create!(title: "Okay shelter!", rating: 2, content: "Too many sad dogs.", picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg", shelter_id: test_shelter.id)
  
    visit "/shelters/#{test_shelter.id}"
  
    expect(current_path).to eq("/shelters/#{test_shelter.id}")
    expect(page).to have_content("#{shelter_review.title}")
    expect(page).to have_content("Rating: #{shelter_review.rating}/5")
    expect(page).to have_content("#{shelter_review.content}")
    expect(page).to have_xpath("//img[@src='#{shelter_review.picture}']")
  
    expect(ShelterReview.find_by_id(shelter_review.id).nil?).to eq(false)
  
    click_on "Delete Shelter"
  
    expect(current_path).to eq("/shelters")
    expect(ShelterReview.find_by_id(shelter_review.id).nil?).to eq(true)
  end
  
  it "I get an 'Delete' link for each shelter in '/shelters" do
  
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
  
  it "I cannot delete a shelter if it has pending pet applications" do

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

  within("navbar") do
    click_link "Shelter Index"
  end
  
  expect(current_path).to eq("/shelters")
  
  click_link "Delete"
  expect(current_path).to eq("/shelters")
  expect(page).to have_content("Unable to delete #{test_shelter.name}, the shelter has has pending applications")

  end
  
  it "I can delete a shelter and pets if it has no pending pet applications" do

  test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
  pet1 = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: test_shelter.id, status: "Adoptable")
  pet2 = Pet.create!(name: "Buddy", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "3", sex: "Female", shelter_id: test_shelter.id, status: "Adoptable")
  adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
  PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet1.id, status: "Pending")
  PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet2.id, status: "Pending")
  
  visit "/shelters"
  
  expect(page).to have_content("#{test_shelter.name}")
  expect(Shelter.all.empty?).to eq(false)
  expect(Pet.all.empty?).to eq(false)
  
  click_link "Delete"
  
  expect(current_path).to eq("/shelters")
  expect(page).to_not have_content("#{test_shelter.name}")
  expect(Shelter.all.empty?).to eq(true)
  expect(Pet.all.empty?).to eq(true)
  
  end
end