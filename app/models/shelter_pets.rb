class ShelterPets< ApplicationRecord
  has_many :pets, dependent: :delete_all
  belongs_to :shelter
end