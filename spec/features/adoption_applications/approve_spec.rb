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
    expect(page).to have_content("Adoption Status: Pending")
    expect(page).to have_content("On hold for #{adoption_application.name}")
    # pry under pet in controller #show action, use dot notation off of the pet to get applicant name
    # update view to check whether pet's adoption status is pending and if so show the above text
  end
end
