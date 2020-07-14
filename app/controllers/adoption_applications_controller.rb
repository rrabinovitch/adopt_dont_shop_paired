class AdoptionApplicationsController < ApplicationController
  def new
    @favorites = Pet.find(favorite_pets.favorite_pets)
  end

  def create
    adoption_application = AdoptionApplication.create(adoption_application_params)

    if !adoption_application.save || !validate_pet_ids
      flash[:notice] = "Unsuccessful application submission: please fill in all application fields."
      redirect_to "/adoption_applications/new"
    elsif adoption_application.save && validate_pet_ids
      make_pet_adoption_applications(params[:pet_ids], adoption_application)
      flash[:notice] = "Your adoption application has been submitted!"
      redirect_to '/favorites'
    end
  end

  def show
    @adoption_application = AdoptionApplication.find(params[:id])
  end

  private

  def adoption_application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end

  def make_pet_adoption_applications(selected_pet_ids, adoption_application)
    selected_pet_ids.each do |pet_id|
      session[:favorites].delete(pet_id)
      PetAdoptionApplication.create(adoption_application_id: adoption_application.id, pet_id: pet_id)
    end
  end

  def validate_pet_ids
    return false if params[:pet_ids].nil?
    params[:pet_ids].all? do |pet_id|
      Pet.exists?(pet_id)
    end
  end
end
