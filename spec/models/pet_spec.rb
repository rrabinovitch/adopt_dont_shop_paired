require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "relationships" do
    it {should belong_to(:shelter)}
  end

  describe "class methods" do
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
  end
end
