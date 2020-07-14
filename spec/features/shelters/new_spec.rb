require 'rails_helper'

RSpec.describe "New shelter", type: :feature do
  it 'I can create a new shelter' do
    visit '/shelters'

    click_link 'New Shelter'

    expect(current_path).to eq('/shelters/new')

    fill_in 'Name', with: 'Test Shelter'
    fill_in 'Address', with: '123 Rocky Rd.'
    fill_in 'City', with: 'Boulder'
    fill_in 'State', with: 'CO'
    fill_in 'Zip', with: '81443'
    click_on 'Create Shelter'

    expect(current_path).to eq("/shelters")
    expect(page).to have_content('Test Shelter')
  end
  
  it "It tells me if I missed an input field" do
    visit "/shelters/new"
    
    fill_in 'Name', with: 'Test Shelter'
    fill_in 'Address', with: ''
    fill_in 'City', with: ''
    fill_in 'State', with: ''
    fill_in 'Zip', with: ''

    click_on "Create Shelter"

    expect(current_path).to eq("/shelters/new")

    expect(page).to have_content('Unsuccessful shelter submission, please fill in the following fields prior to submission: ["address", "city", "state", "zip"]')

    
  end
end
