class ShelterPets< ApplicationRecord
  has_many :pets
  belongs_to :shelter
end