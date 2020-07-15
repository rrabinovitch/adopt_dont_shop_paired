require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it "When I visit '/shelters/:id' then I see that shelters's info" do
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")

    visit "/shelters/#{test_shelter.id}"

    expect(page).to have_content("#{test_shelter.name}")
    expect(page).to have_content("Address: #{test_shelter.address}")
    expect(page).to have_content("City: #{test_shelter.city}")
    expect(page).to have_content("State: #{test_shelter.state}")
    expect(page).to have_content("Zip: #{test_shelter.zip}")

    # ADD BELOW CODE TO SHELTER PETS INDEX PAGE TEST
    # click_link "Pets Page"
    #
    # expect(current_path).to eq("/shelters/#{test_shelter.id}/pets")
  end

  it "when I visit '/shelters/:id' then I see a list of reviews for that shelter" do
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")

    shelter_review = ShelterReview.create!(title: "Okay shelter!", rating: 2, content: "Too many sad dogs.", picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg", shelter_id: test_shelter.id)

    visit "/shelters/#{test_shelter.id}"

    expect(page).to have_content("#{shelter_review.title}")
    expect(page).to have_content("Rating: #{shelter_review.rating}/5")
    expect(page).to have_content("#{shelter_review.content}")
    expect(page).to have_xpath("//img[@src='#{shelter_review.picture}']")
  end

  it "when I visit '/shelters/:id' I see available pet quantity, average review rating and number of applications on file" do
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
    shelter_review_1 = ShelterReview.create!(title: "Okay shelter!", rating: 2, content: "Too many sad dogs.", picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg", shelter_id: test_shelter.id)
    shelter_review_2 = ShelterReview.create!(title: "Good shelter!", rating: 4, content: "Too many OK dogs.",picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg", shelter_id: test_shelter.id)
    pet1 = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: test_shelter.id, status: "Adoptable")
    pet2 = Pet.create!(name: "Buddy", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "3", sex: "Female", shelter_id: test_shelter.id, status: "Adoptable")
    adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet1.id, status: "Pending")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet2.id, status: "Pending")

    visit "/shelters/#{test_shelter.id}"

    expect(page).to have_content("Available Pets: 2")
    expect(page).to have_content("Average Review Rating: 3")
    expect(page).to have_content("Number of Applications on File: 2")

  end
end
