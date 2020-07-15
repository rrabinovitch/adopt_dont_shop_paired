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
    @adoption_application = @pet.adoption_applications[0]
    # should probably use a join b/w pets <> adoption applications where pets.id = @pet.id & pets.status = pending
  end

  def new

  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    redirect_to "/pets/#{params[:id]}"
  end

  def destroy
    pet = Pet.find(params[:id])
    session[:favorites].delete(pet.id.to_s) if session[:favorites] != nil
    Pet.destroy(params[:id])
    redirect_to "/pets/"
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :approximate_age, :sex, :status)
  end
end
