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

  it "No favorited pets" do
    visit "/favorites"
    expect(page).to have_content("No pets to see here. Explore pets here and select some of your favorites!")
  end

  it "Link to apply to adopt favorited pets" do
    shelter = Shelter.create(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")

    visit "/pets/#{pet1.id}"
    click_on 'Favorite'

    visit "/favorites"

    click_on 'Apply to adopt your favorite pets'

    expect(current_path).to eq("/adoption_applications/new")
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

  it "The favorite indicator links to the favorites index page from anywhere on site" do
    visit "/"

    within("navbar") do
      click_on "Favorites - 0"
    end

    expect(current_path).to eq('/favorites')
  end

  it "The favorite indicator links to the favorites index page from favorites page" do
    visit "/favorites"

    within("navbar") do
      click_on "Favorites - 0"
    end

    expect(current_path).to eq('/favorites')
  end
end
