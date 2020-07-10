require 'rails_helper'

RSpec.describe "When a user adds a pet to their favorites" do
  it "flash message displays and favorites indicator increments by 1" do
    shelter = Shelter.create(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
    pet = Pet.create(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")

    visit "/pets/#{pet.id}"

    within("navbar") do
      expect(page).to have_content("Favorites - 0")
    end

    click_button "Favorite"

    expect(current_path).to eq("/pets/#{pet.id}")

    expect(page).to have_content("#{pet.name} has been added to your favorites list.")

    within("navbar") do
      expect(page).to have_content("Favorites - 1")
    end
  end
end
