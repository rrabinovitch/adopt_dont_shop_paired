class Pet < ApplicationRecord
  attr_reader :has_application

  belongs_to :shelter
  has_many :pet_adoption_applications, dependent: :delete_all
  has_many :adoption_applications, through: :pet_adoption_applications

  def self.sort_by_status
    Pet.order(status: :asc)
  end

  def self.has_application
    Pet.select(:name, :id).joins(:pet_adoption_applications).uniq
  end

  def adoptable?
    status == "Adoptable"
  end

  def pending?
    status == "Pending"
  end
end
