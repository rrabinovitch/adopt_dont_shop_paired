require 'rails_helper'

RSpec.describe "Adoption application show page", type: :feature do
  it "Displays application details" do
    shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    pet2 = Pet.create!(name: "George", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "11", sex: "Male", shelter_id: shelter.id, status: "Adoptable")
    adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet1.id, status: "Pending")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet2.id, status: "Pending")

    visit "/adoption_applications/#{adoption_application.id}"

    expect(page).to have_content("#{adoption_application.name}'s application:")
    expect(page).to have_content("Address: #{adoption_application.address}")
    expect(page).to have_content("City: #{adoption_application.city}")
    expect(page).to have_content("State: #{adoption_application.state}")
    expect(page).to have_content("Zip: #{adoption_application.zip}")
    expect(page).to have_content("Phone Number: #{adoption_application.phone_number}")
    expect(page).to have_content("Why: #{adoption_application.description}")
    expect(page).to have_content("Pets applied for:")
    adoption_application.pets.each do |pet|
      expect(page).to have_content(pet.name)
    end
  end
end
