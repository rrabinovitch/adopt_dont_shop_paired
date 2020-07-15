require 'rails_helper'

RSpec.describe "Application approval", type: :feature do
  it "An adoption application's show page has links to approve the adoption of each pet applied for" do
    shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    pet2 = Pet.create!(name: "George", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "11", sex: "Male", shelter_id: shelter.id, status: "Adoptable")
    adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet1.id, status: "Pending")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet2.id, status: "Pending")

    visit "/adoption_applications/#{adoption_application.id}"

    expect(page).to have_button("Approve application for #{pet2.name}")

    click_on "Approve application for #{pet1.name}"

    expect(current_path).to eq("/pets/#{pet1.id}")
  end

  it "An application for multiple pets can be approved for any number of pets" do
    shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    pet2 = Pet.create!(name: "George", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "11", sex: "Male", shelter_id: shelter.id, status: "Adoptable")
    adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet1.id, status: "Pending")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet2.id, status: "Pending")

    visit "/adoption_applications/#{adoption_application.id}"

    click_on "Approve application for #{pet1.name}"
  
    expect(page).to have_content("Adoption Status: Pending")

    visit "/adoption_applications/#{adoption_application.id}"
    click_on "Approve application for #{pet2.name}"
    expect(page).to have_content("Adoption Status: Pending")
  end

  it "Only one application can be approved for each pet but other applications remain on file" do
    shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    adoption_application1 = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application1.id, pet_id: pet.id, status: "Pending")
    adoption_application2 = AdoptionApplication.create!(name: "Garrett G", address: "4586 Main St", city: "Boulder", state: "CO", zip: "80345", phone_number: "554-234-1575", description: "I deserve them.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application2.id, pet_id: pet.id, status: "Pending")

    visit "/adoption_applications/#{adoption_application1.id}"

    click_on "Approve application for #{pet.name}"

    visit "/adoption_applications/#{adoption_application2.id}"
    expect(page).to_not have_content("Approve application for #{pet.name}")
    expect(page).to have_content("#{pet.name}'s adoption is pending.")

    visit "/pets/#{pet.id}/adoption_applications"
    expect(page).to have_link(adoption_application2.name)
  end

  it "Approved applications can be revoked" do
    shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet.id, status: "Pending")

    visit "/adoption_applications/#{adoption_application.id}"
    click_on "Approve application for #{pet.name}"

    visit "/adoption_applications/#{adoption_application.id}"
    expect(page).to_not have_content("Approve application for #{pet.name}")
    click_on "Revoke application for #{pet.name}"

    expect(current_path).to eq("/pets/#{pet.id}")
    expect(page).to have_content("Adoption Status: Adoptable")
  end
end
