require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do

  it "When I visit '/shelters/:id' then I see that shelters's info" do

    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
    visit "/shelters/#{test_shelter.id}"

    click_link "Pets Page"

    expect(current_path).to eq("/shelters/#{test_shelter.id}/pets")
  end

  it "when I visit '/shelters/:id' then I see a list of reviews for that shelter" do
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
    review = ShelterReview.create!(title: "Great shelter!", rating: 2, content: "Too many sad dogs.", picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg", shelter_id: test_shelter.id)

    visit "/shelters/#{test_shelter.id}"

    expect(page).to have_content("#{review.title}")
    expect(page).to have_content("Rating: #{review.rating}/5")
    expect(page).to have_content("#{review.content}")
    expect(page).to have_xpath("//img[@src='#{review.picture}']")
  end

end
