class PetsController < ApplicationController
  def index
    @pets = Pet.all.sort_by_status
  end

  def show
    @pet = Pet.find(params[:id])
    if session[:favorites] != nil
      @favorites = session[:favorites]
    else
      @favorites = []
    end
    # pet_adoption_application = PetAdoptionApplication.find_by(pet_id: @pet.id, status: "Approved")
    # adoption_application = AdoptionApplication.find(pet_adoption_application.adoption_application_id)
    # @applicant_name = adoption_application.name
  end

  def new

  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])

    missing_fields = pet_params.select{|_,user_input| user_input.nil? || user_input == ""}.keys
    if missing_fields.empty?
      pet.update(pet_params)
      redirect_to "/pets/#{params[:id]}"
    else
      flash[:notice] = "Unsuccessful shelter submission, please fill in the following fields prior to submission: #{missing_fields.each { |field| p "#{field} "}}"
      redirect_to "/pets/#{params[:id]}/edit"
    end

  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.status == "Pending"
      flash[:notice] = "Unable to delete #{pet.name} because it has an approved application"
      redirect_to "/pets/#{pet.id}"
    else
      session[:favorites].delete(pet.id.to_s) if session[:favorites] != nil
      Pet.destroy(params[:id])
      redirect_to "/pets/"
    end
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :approximate_age, :sex, :status)
  end
end
