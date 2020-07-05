class ShelterPetsController < ApplicationController
  
  def new
    @shelter_id = params[:id]
  end
  
  def create
    pet = Pet.new({
              name: params[:name],
              image: params[:image],
              description: params[:description],
              approximate_age: params[:approximate_age],
              sex: params[:sex],
              status: "adoptable",
              shelter_id: params[:id]
              })
              
    pet.save
    redirect_to "/shelters/#{params[:id]}/pets/"
  end
  
end