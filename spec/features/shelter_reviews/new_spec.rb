require 'rails_helper'

RSpec.describe "Shelter review creation", type: :feature do

  it "I can create a new shelter review without a picture" do
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")

    visit "/shelters/#{test_shelter.id}"

    click_on "New Review"

    title = "Ok shelter"
    rating = 3
    content = "It is a shelter"

    expect(current_path).to eq("/shelters/#{test_shelter.id}/reviews/new"
    fill_in 'Title', with: title
    fill_in 'Rating', with: rating
    fill_in 'Content', with: content

    click_on "Submit Review"

    expect(current_path).to eq("/shelters/#{test_shelter.id}")

    expect(page).to have_content("#{title}")
    expect(page).to have_content("Rating: #{rating}/5")
    expect(page).to have_content("#{content}")
  end

  it "I can create a new shelter review with a picture" do
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")

    visit "/shelters/#{test_shelter.id}"

    click_on "New Review"

    title = "Ok shelter"
    rating = 3
    content = "It is a shelter"
    picture = "https://image.flaticon.com/icons/png/512/3/3901.png"

    expect(current_path).to eq("/shelters/#{test_shelter.id}/reviews/new")

    fill_in 'Title', with: title
    fill_in 'Rating', with: rating
    fill_in 'Content', with: content
    fill_in 'Picture', with: picture

    click_on "Submit Review"

    expect(current_path).to eq("/shelters/#{test_shelter.id}")

    expect(page).to have_content("#{title}")
    expect(page).to have_content("Rating: #{rating}/5")
    expect(page).to have_content("#{content}")
    expect(page).to have_xpath("//img[@src='https://image.flaticon.com/icons/png/512/3/3901.png']")
  end


end
