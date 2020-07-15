class Shelter < ApplicationRecord
  has_many :pets, dependent: :delete_all
  has_many :shelter_reviews, dependent: :delete_all
  
  def applications_total
    PetAdoptionApplication.joins(:pet).where('pets.shelter_id = ?', id).count
  end
end


