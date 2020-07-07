class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.new({
              name: params[:name],
              address: params[:address],
              city: params[:city],
              state: params[:state],
              zip: params[:zip]
              })
    shelter.save
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{params[:id]}"
  end

  def show
    @shelter = Shelter.find(params[:id])
    @pets = @shelter.pets
    # ^ consider removing bc we dont reference pets on the show page
    @shelter_reviews = @shelter.shelter_reviews
    binding.pry
    # @shelter_reviews = ShelterReview.where("shelter_id=#{params[:id]}")
    # binding.pry
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to "/shelters"
  end

  def pets_index
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets.sort_by_status
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
