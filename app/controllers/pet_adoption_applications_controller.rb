class PetAdoptionApplicationsController < ApplicationController
  def index
    pet_id = params[:id]
    @pet = Pet.find(pet_id)
    @adoption_applications = AdoptionApplication.joins(:pets).where(pets: {id: pet_id})
  end

  def update
    pet_id = params[:pet_id]
    pet = Pet.find(pet_id)
    pet.update(status: "Pending")
    redirect_to "/pets/#{pet_id}"
  end
end
