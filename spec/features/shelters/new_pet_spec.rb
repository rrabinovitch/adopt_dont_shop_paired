require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  it 'When I visit Shelter Pets Index page I see a link to add a new pet for that shelter' do
    @shelter = Shelter.create(name: "Shelter A")

    visit "/shelters/#{@shelter.id}/pets"

    click_link "Create Pet"

    visit "/shelters/#{@shelter.id}/pets/"

    expect(page).to have_content("Create Pet")
  end

  it "I am taken to '/shelters/:shelter_id/pets/new' where I see a form to add a new adoptable pet" do
    @shelter = Shelter.create(name: "Shelter A")

    visit "/shelters/#{@shelter.id}/pets/new"

    fill_in 'Image', with: 'https://upload.wikimedia.org/wikipedia/commons/4/42/Beagle1.jpg'
    fill_in 'Name', with: 'Happy'
    fill_in 'Description', with: 'Happiest beagle ever!'
    fill_in 'Approximate age', with: '8'
    fill_in 'Sex', with: 'Male'
    click_on 'Create Pet'

    expect(current_path).to eq("/shelters/#{@shelter.id}/pets")
    expect(page).to have_content('Happy')
    expect(page).to have_content('Happiest beagle ever!')
    expect(page).to have_content('8')
    expect(page).to have_content('Male')
  end
  
  it "When creating a new pet it tells me if I missed an input field" do
    @shelter = Shelter.create(name: "Shelter A")
    
    visit "/shelters/#{@shelter.id}/pets"
    
    click_link 'Create Pet'
    
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")
    
    fill_in 'Name', with: 'Happy'
    fill_in 'Image', with: 'https://upload.wikimedia.org/wikipedia/commons/4/42/Beagle1.jpg'
    fill_in 'Description', with: ''
    fill_in 'Approximate age', with: ''
    fill_in 'Sex', with: ''

    click_on 'Create Pet'
    save_and_open_page
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")
    expect(page).to have_content('Unsuccessful shelter submission, please fill in the following fields prior to submission: ["description", "approximate_age", "sex"]')

  end
end
