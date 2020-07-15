require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do

  it 'When I visit a Pet Show page I see a link to Update Pet' do
    @shelter = Shelter.create(name: "Shelter A")

    @pet = Pet.create(
              image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: @shelter.id,
              description: "A loving 3 year old pup looking for a partner to play fetch with!",
              status: "Adoptable"
              )

    visit "/pets/#{@pet.id}"
    expect(page).to have_content("Update Pet")
    click_link "Update Pet"
    expect(current_path).to eq("/pets/#{@pet.id}/edit")

  end

  it "I am taken to '/pets/:id/edit' where I see a form to edit the pet's data" do
    @shelter = Shelter.create(name: "Shelter A")

    @pet = Pet.create(
              image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: @shelter.id,
              description: "A loving 3 year old pup looking for a partner to play fetch with!",
              status: "Adoptable"
              )

    visit "/pets/#{@pet.id}/edit"

    fill_in 'Image', with: 'https://upload.wikimedia.org/wikipedia/commons/4/42/Beagle1.jpg'
    fill_in 'Name', with: 'Happy'
    fill_in 'Description', with: 'Happiest beagle ever!'
    fill_in 'Approximate age', with: '8'
    fill_in 'Sex', with: 'Male'
    fill_in 'Status', with: 'Adoptable'
    click_on 'Update Pet'

    expect(current_path).to eq("/pets/#{@pet.id}")
    expect(page).to have_content('Happy')
    expect(page).to have_content('Happiest beagle ever!')
    expect(page).to have_content('8')
    expect(page).to have_content('Male')
    expect(page).to have_content('Adoptable')
  end

  it "I get an 'Edit Information' link for each Pet in '/pets" do
    @shelter = Shelter.create(name: "Shelter A")

    @pet = Pet.create(
              image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
              name: "Bailey",
              approximate_age: "3",
              sex: "Female",
              shelter_id: @shelter.id,
              description: "A loving 3 year old pup looking for a partner to play fetch with!",
              status: "Adoptable"
              )

    visit "/pets"

    click_on 'Edit Information'

    fill_in 'Image', with: 'https://upload.wikimedia.org/wikipedia/commons/4/42/Beagle1.jpg'
    fill_in 'Name', with: 'Happy'
    fill_in 'Description', with: 'Happiest beagle ever!'
    fill_in 'Approximate age', with: '8'
    fill_in 'Sex', with: 'Male'
    fill_in 'Status', with: 'Adoptable'
    click_on 'Update Pet'

    expect(current_path).to eq("/pets/#{@pet.id}")
    expect(page).to have_content('Happy')
    expect(page).to have_content('Happiest beagle ever!')
    expect(page).to have_content('8')
    expect(page).to have_content('Male')
    expect(page).to have_content('Adoptable')
  end
end
