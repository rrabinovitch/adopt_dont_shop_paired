require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "relationships" do
    it {should have_many(:pets)}
    it {should have_many(:shelter_reviews)}
  end

  it ".applications_total" do
    test_shelter = Shelter.create!(name: "Test Shelter", address: "114 Test Address", city: "Test City", state: "CO", zip: "80202")
    shelter_review_1 = ShelterReview.create!(title: "Okay shelter!", rating: 2, content: "Too many sad dogs.", picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg", shelter_id: test_shelter.id)
    shelter_review_2 = ShelterReview.create!(title: "Good shelter!", rating: 4, content: "Too many OK dogs.",picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg", shelter_id: test_shelter.id)
    pet1 = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: test_shelter.id, status: "Adoptable")
    pet2 = Pet.create!(name: "Buddy", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "3", sex: "Female", shelter_id: test_shelter.id, status: "Adoptable")
    adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet1.id)
    PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet2.id)
    
    applications = test_shelter.applications_total
    expect(applications).to eq(PetAdoptionApplication.all.length)
  end
end
