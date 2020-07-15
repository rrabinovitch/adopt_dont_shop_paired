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
    # PetAdoptionApplication.find_by("pet_id = #{params[:pet_id]} and adoption_application_id = #{params[:pet_adoption_application_id]}")
    #
    # pet = Pet.find(params[:pet_id])
    # pet.update(status: "Pending")
    # binding.pry
    redirect_to "/pets/#{params[:pet_id]}"
    # have access to pet adoption application through the id
    # update pet adoption application status to whatever it's not


    # add app.approved? helper method

  end
end
