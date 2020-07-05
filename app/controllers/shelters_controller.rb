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
    # binding.pry
    @shelter = Shelter.find(params[:id])
  end
  
  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{params[:id]}"
  end
  
  def show
    @shelter = Shelter.find(params[:id])
  end
  
  def destroy
    Shelter.destroy(params[:id])
    redirect_to "/shelters"
  end
  
  def pets_index
  
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end