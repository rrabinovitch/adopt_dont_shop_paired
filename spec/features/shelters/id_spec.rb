require 'rails_helper'

RSpec.describe "visit a shelter show page", type: :feature do
  
  it "shows information by ID" do
    
    shelter_1 = Shelter.create({
              name: "Primary Shelter",
              address: "123 Maple Ave.",
              city: "Denver",
              state: "CO",
              zip: "80438"
              })
    
    visit "/shelters/#{shelter_1.id}"
    
    expect(page).to have_content(shelter_1.name)
    
  end
end