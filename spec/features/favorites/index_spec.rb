
require 'rails_helper'

RSpec.describe "Favorite's Index Page", type: :feature do
  it "The index page displays favorited pets" do
    shelter = Shelter.create(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")

    visit "/pets/#{pet1.id}"
    
    click_on 'Favorite'
    
    within("navbar") do
      click_on "Favorites - 1"
    end
    
    expect(current_path).to eq('/favorites')
    expect(page).to have_content(pet1.name)
    expect(page).to have_xpath("//img[@src='#{pet1.image}']")
  end
  
  it "Gives the option to delete a pet in the favorites index page" do
    shelter = Shelter.create(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")

    visit "/pets/#{pet1.id}"
    
    click_on 'Favorite'
    
    within("navbar") do
      click_on "Favorites - 1"
    end
    expect(current_path).to eq("/favorites")
    expect(page).to have_button('Remove Pet From Favorites')
    
    click_button 'Remove Pet From Favorites'
    
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("#{pet1.name} has been removed to your favorites list.")
    expect(page).to_not have_xpath("//img[@src='#{pet1.image}']")

    
    
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
