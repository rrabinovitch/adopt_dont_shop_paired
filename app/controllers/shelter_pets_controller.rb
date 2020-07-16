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

    missing_fields = pet_params.select{|_,user_input| user_input.nil? || user_input == ""}.keys
    if missing_fields.empty?
      pet.save
      redirect_to "/shelters/#{params[:id]}/pets"
    else
      flash[:notice] = "Unsuccessful shelter submission, please fill in the following fields prior to submission: #{missing_fields.each { |field| "#{field} "}}"
      redirect_to "/shelters/#{params[:id]}/pets/new"
    end



  end

  def pet_params
    params.permit(:image, :name, :description, :approximate_age, :sex, :status)
  end

end
