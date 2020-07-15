require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it { should belong_to :shelter }
    it { should have_many :pet_adoption_applications }
    it { should have_many(:adoption_applications).through(:pet_adoption_applications) }
  end

  describe "methods" do
    it ".sort_by_status" do
      shelter = Shelter.create(name: "Best Shelter", address: "743 Mountain Drive", city: "Golden", state: "CO", zip: "80433")

      test_pet1 = Pet.create(
                image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
                name: "Bella",
                approximate_age: "13",
                sex: "Female",
                shelter_id: shelter.id,
                status: "Adoptable"
                )
      test_pet2 = Pet.create(
                image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
                name: "Bailey",
                approximate_age: "3",
                sex: "Female",
                shelter_id: shelter.id,
                status: "Pending"
                )
      test_pet3 = Pet.create(
                image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg",
                name: "Boots",
                approximate_age: "5",
                sex: "Male",
                shelter_id: shelter.id,
                status: "Adoptable"
                )
      expected = [test_pet1, test_pet3, test_pet2]
      expect(Pet.sort_by_status).to eq(expected)
    end

    it "#adoptable?" do
      shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
      pet1 = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
      pet2 = Pet.create!(name: "George", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "11", sex: "Male", shelter_id: shelter.id, status: "Pending")      # adoption_application1 = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")

      expect(pet1.adoptable?).to eq(true)
      expect(pet2.adoptable?).to eq(false)
    end
  end
end
