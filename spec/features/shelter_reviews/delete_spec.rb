require 'rails_helper'

RSpec.describe "Delete a shelter review", type: :feature do

  it "I can delete a review from a shelter show page" do
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
    shelter_review = ShelterReview.create!(title: "Okay shelter!", rating: 2, content: "Too many sad dogs.", picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg", shelter_id: test_shelter.id)

    visit "/shelters/#{test_shelter.id}"

    expect(current_path).to eq("/shelters/#{test_shelter.id}")
    expect(page).to have_content("#{shelter_review.title}")
    expect(page).to have_content("Rating: #{shelter_review.rating}/5")
    expect(page).to have_content("#{shelter_review.content}")
    expect(page).to have_xpath("//img[@src='#{shelter_review.picture}']")

    click_on "Delete Review"
    
    expect(current_path).to eq("/shelters/#{test_shelter.id}")
    expect(page).to_not have_content("#{shelter_review.title}")
    expect(page).to_not have_content("Rating: #{shelter_review.rating}/5")
    expect(page).to_not have_content("#{shelter_review.content}")
    expect(page).to_not have_xpath("//img[@src='#{shelter_review.picture}']")
  end

end