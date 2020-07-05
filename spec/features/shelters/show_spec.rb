require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do

  it "When I visit '/shelters/:id' then I see that shelters's info" do
    
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
    visit "/shelters/#{test_shelter.id}"

    click_link "Pets Page"
    
    expect(current_path).to eq("/shelters/#{test_shelter.id}/pets")
    
  end
  
  
end