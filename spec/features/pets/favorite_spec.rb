
require 'rails_helper'

RSpec.describe "Favorite indicator", type: :feature do
  
  it "In the navigation bar there is a link showing the number of pets in my favorites list" do
    
    visit "/"
    favorites = 0
    #Added line for testing merge
    within("navbar") do
      expect(page).to have_content("Favorites - #{favorites}")
    end
  end
end