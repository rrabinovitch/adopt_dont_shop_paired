require 'rails_helper'

RSpec.describe PetAdoptionApplication, type: :model do
  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :adoption_application }
  end

  describe "validations" do
    it { should validate_presence_of :pet_id }
    it { should validate_presence_of :adoption_application_id }
    it { should validate_presence_of :status }
  end

  describe "methods" do
    it "#approved?" do
      shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
      pet = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
      adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
      pet_adoption_application = PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet.id, status: "Pending")

      expect(pet_adoption_application.approved?).to eq(false)
      pet_adoption_application.update(status: "Approved")
      expect(pet_adoption_application.approved?).to eq(true)
    end

    it "#pending?" do
      shelter = Shelter.create!(name: "Primary Shelter", address: "123 Maple Ave.", city: "Denver", state: "CO", zip: "80438")
      pet = Pet.create!(name: "Bonnie", image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", approximate_age: "13", sex: "Female", shelter_id: shelter.id, status: "Adoptable")
      adoption_application = AdoptionApplication.create!(name: "Ruthie R", address: "1245 Turing Ave", city: "Denver", state: "CO", zip: "80250", phone_number: "253-555-1843", description: "I love animals and I want them all.")
      pet_adoption_application = PetAdoptionApplication.create!(adoption_application_id: adoption_application.id, pet_id: pet.id, status: "Pending")

      expect(pet_adoption_application.pending?).to eq(true)
      pet_adoption_application.update(status: "Approved")
      expect(pet_adoption_application.pending?).to eq(false)
    end
  end
end
