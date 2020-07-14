class Shelter < ApplicationRecord
  has_many :pets, dependent: :delete_all
  has_many :shelter_reviews, dependent: :delete_all
end
