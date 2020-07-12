class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_adoption_applications
  has_many :adoption_applications, through: :pet_adoption_applications

  def self.sort_by_status
    Pet.order(status: :asc)
  end
end
