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

  visit "/shelters"

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
end
