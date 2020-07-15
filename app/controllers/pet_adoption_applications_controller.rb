class PetAdoptionApplicationsController < ApplicationController
  def index
    pet_id = params[:id]
    @pet = Pet.find(pet_id)
    @adoption_applications = AdoptionApplication.joins(:pets).where(pets: {id: pet_id})
  end

  def update
    pet_adoption_application = PetAdoptionApplication.find(params[:pet_adoption_application_id])
    pet = Pet.find(params[:pet_id])
    # binding.pry
    if pet_adoption_application.status == "Pending"
      pet_adoption_application.update(status: "Approved")
      pet.update(status: "Pending")
    elsif pet_adoption_application.status == "Approved"
      pet_adoption_application.update(status: "Pending")
      pet.update(status: "Adoptable")
    end

    redirect_to "/pets/#{params[:pet_id]}"

    # add app.approved? helper method
  end
end
