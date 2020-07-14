class PetAdoptionApplicationsController < ApplicationController
  def show
    pet_id = params[:id]
    @pet = Pet.find(pet_id)
    @adoption_applications = AdoptionApplication.joins(:pets).where(pets: {id: pet_id})
  end
end
