
require 'rails_helper'

RSpec.describe "Favorite indicator and index", type: :feature do
  it "The navigation bar has a favorite indiciator" do
    visit "/"
    favorites = 0

    within("navbar") do
      expect(page).to have_content("Favorites - #{favorites}")
    end
  end

  it "The favorite indicator links to the favorites index page" do
    visit "/"

    within("navbar") do
      click_on "Favorites - 0"
    end

    expect(current_path).to eq('/favorites')
  end
end
