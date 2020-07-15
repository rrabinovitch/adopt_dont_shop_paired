class PetAdoptionApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :adoption_application
  validates_presence_of :pet_id, :adoption_application_id, :status

  def approved?
    status == "Approved"
  end

  def pending?
    status == "Pending"
  end
end
