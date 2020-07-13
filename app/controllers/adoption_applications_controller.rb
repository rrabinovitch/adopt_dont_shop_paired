class AdoptionApplicationsController < ApplicationController
  def new
    @favorites = Pet.find(favorite_pets.favorite_pets)
  end

  def create
    @adoption_application = AdoptionApplication.create(adoption_application_params)
    if @adoption_application.save
      @selected_pet_ids = params[:pet_ids]
      @selected_pet_ids.each do |pet_id|
        session[:favorites].delete(pet_id)
        PetAdoptionApplication.create(adoption_application_id: @adoption_application.id, pet_id: pet_id)
      end
      flash[:notice] = "Your adoption application has been submitted!"
      redirect_to '/favorites'
    else
      flash[:notice] = "Unsuccessful application submission: please fill in all application fields."
      redirect_to "/adoption_applications/new"
    end
  end

  def show
    @adoption_application = AdoptionApplication.find(params[:id])
  end

  private

  def adoption_application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
