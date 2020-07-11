
require 'rails_helper'

RSpec.describe "Favorite indicator and index", type: :feature do
  it "The navigation bar has a favorite indiciator" do
    shelter = Shelter.create(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
    pet2 = Pet.create(name: "Bonnie", image: "http://clipart-library.com/img/1678223.jpg", approximate_age: "2", sex: "Male", shelter_id: shelter.id, status: "Adoptable")
    # @favorites = Favorites.new(["#{pet1.id}", "#{pet2.id}"])

    visit "/favorites"
    
    expect(page)
    
    
  end
end


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
  
  it "The favorite indicator links to the favorites index page" do
    visit "/favorites"

    within("navbar") do
      click_on "Favorites - 0"
    end

    expect(current_path).to eq('/favorites')
  end
  
end
