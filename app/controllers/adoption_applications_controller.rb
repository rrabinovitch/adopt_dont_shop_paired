class AdoptionApplicationsController < ApplicationController
  def new
    @favorites = Pet.find(favorite_pets.favorite_pets)
  end

  def create
    @selected_pet_ids = params[:pet_ids]
    @adoption_application = AdoptionApplication.create(adoption_application_params)
    if @adoption_application.save
      @selected_pet_ids.each do |pet_id|
        session[:favorites].delete(pet_id)
        PetAdoptionApplication.create(adoption_application_id: @adoption_application.id, pet_id: pet_id)
      end
      flash[:notice] = "Your adoption application has been submitted!"
      redirect_to '/favorites'
    # else
    #   flash[:notice] = "Unsuccessful application submission: please fill in all application fields."
    end
  end

  private

  def adoption_application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end