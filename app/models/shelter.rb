class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :shelter_reviews, dependent: :delete_all
  
  def applications_total
    PetAdoptionApplication.joins(:pet).where('pets.shelter_id = ?', id).count
  end

  def self.has_pending_applications?(shelter_id)
    pending_applications = Pet.where(shelter_id: shelter_id, status:  'Pending')
    if pending_applications.empty?
      false
    else
      true
    end
  end
end