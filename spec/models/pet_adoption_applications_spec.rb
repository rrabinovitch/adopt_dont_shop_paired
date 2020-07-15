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
end
