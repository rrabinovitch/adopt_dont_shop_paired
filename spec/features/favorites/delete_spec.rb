
require 'rails_helper'

RSpec.describe "Pet show page", type: :feature do
  it "Pet show pages will give a 'remove pet from favorites' option if animal is already favorited " do
    shelter = Shelter.create(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")

    visit "/pets/#{pet1.id}"
    expect(page).to have_content('Favorite')

    click_button 'Favorite'
    visit current_path

    click_button 'Remove Pet From Favorites'

    within("navbar") do
      click_link "Favorites - 0"
    end

    expect(current_path).to eq("/favorites")
    expect(page).to_not have_content(pet1.name)
    expect(page).to_not have_xpath("//img[@src='#{pet1.image}']")

  end

  it "Pet show pages will give a 'Remove All Pets From Favorites'" do
    shelter = Shelter.create(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet1 = Pet.create(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")

    visit "/pets/#{pet1.id}"

    expect(page).to have_content('Favorite')

    click_button 'Favorite'

    within("navbar") do
      click_link "Favorites - 1"
    end

    expect(current_path).to eq("/favorites")
    expect(page).to have_content(pet1.name)
    expect(page).to have_xpath("//img[@src='#{pet1.image}']")
    expect(page).to have_button('Remove All Pets From Favorites')

    click_button 'Remove All Pets From Favorites'

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("All pets have been removed from the favorites list")
    expect(page).to_not have_content(pet1.name)
    expect(page).to_not have_xpath("//img[@src='#{pet1.image}']")
  end
end
