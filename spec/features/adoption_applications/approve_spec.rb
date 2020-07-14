require 'rails_helper'

RSpec.describe "Application approval", type: :feature do
  it "An adoption application's show page has links to approve the adoption of each pet applied for" do
    shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    pet2 = Pet.create!(name: "George", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "11", sex: "Male", shelter_id: shelter.id, status: "Adoptable")
    adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet1.id)
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet2.id)

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
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet1.id)
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet2.id)

    visit "/adoption_applications/#{adoption_application.id}"

    click_on "Approve application for #{pet1.name}"
    expect(page).to have_content("Adoption Status: Pending")
    expect(page).to have_content("On hold for #{adoption_application.name}")

    visit "/adoption_applications/#{adoption_application.id}"
    click_on "Approve application for #{pet2.name}"
    expect(page).to have_content("Adoption Status: Pending")
    expect(page).to have_content("On hold for #{adoption_application.name}")
  end

  it "Only one application can be approved for each pet but other applications remain on file" do
    shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    adoption_application1 = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application1.id, pet_id: pet.id)
    adoption_application2 = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application2.id, pet_id: pet.id)

    visit "/adoption_applications/#{adoption_application1.id}"

    click_on "Approve application for #{pet.name}"

    visit "/adoption_applications/#{adoption_application2.id}"
    expect(page).to_not have_content("Approve application for #{pet.name}")
    expect(page).to have_content("#{pet.name}'s adoption has been approved for another applicant.")

    visit "/pets/#{pet.id}/adoption_applications"
  end
end
