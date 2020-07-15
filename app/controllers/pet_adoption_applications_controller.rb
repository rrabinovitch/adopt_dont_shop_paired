class PetAdoptionApplicationsController < ApplicationController
  def index
    pet_id = params[:id]
    @pet = Pet.find(pet_id)
    @adoption_applications = AdoptionApplication.joins(:pets).where(pets: {id: pet_id})
  end

  def update
    pet_adoption_application = PetAdoptionApplication.find(params[:pet_adoption_application_id])
    pet = Pet.find(params[:pet_id])

    if pet_adoption_application.pending?
      pet_adoption_application.update(status: "Approved")
      pet.update(status: "Pending")
    elsif pet_adoption_application.approved?
      pet_adoption_application.update(status: "Pending")
      pet.update(status: "Adoptable")
    end

    redirect_to "/pets/#{params[:pet_id]}"
  end
end
