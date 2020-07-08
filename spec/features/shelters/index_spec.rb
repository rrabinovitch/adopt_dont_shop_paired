require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do
  it "can visit the page" do
    visit "/shelters"
    expect(page).to have_http_status(200)
  end

  it "can see all shelters" do
    shelter_1 = Shelter.create({
              name: "Primary Shelter",
              address: "123 Maple Ave.",
              city: "Denver",
              state: "CO",
              zip: "80438"
              })
    shelter_2 = Shelter.create({
              name: "Secondary Shelter",
              address: "321 Oak Ave.",
              city: "Denver",
              state: "CO",
              zip: "80438"
              })

    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content("Primary Shelter")
    expect(page).to have_content("Secondary Shelter")
  end
end
