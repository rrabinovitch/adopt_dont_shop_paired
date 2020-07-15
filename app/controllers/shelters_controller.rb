class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.create({
              name: params[:name],
              address: params[:address],
              city: params[:city],
              state: params[:state],
              zip: params[:zip]
              })
              
    missing_fields = shelter_params.select{|_,user_input| user_input.nil? || user_input == ""}.keys
    if missing_fields.empty?
      shelter.save
      redirect_to '/shelters'
    else
      flash[:notice] = "Unsuccessful shelter submission, please fill in the following fields prior to submission: #{missing_fields.each { |field| p "#{field} "}}"
      redirect_to "/shelters/new"
    end

  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    
    missing_fields = shelter_params.select{|_,user_input| user_input.nil? || user_input == ""}.keys
    if missing_fields.empty?
      shelter.update(shelter_params)
      redirect_to "/shelters/#{params[:id]}"
    else
      flash[:notice] = "Unsuccessful shelter submission, please fill in the following fields prior to submission: #{missing_fields.each { |field| p "#{field} "}}"
      redirect_to "/shelters/#{params[:id]}/edit"
    end
    
  
  end

  def show
    @shelter = Shelter.find(params[:id])
    @shelter_reviews = @shelter.shelter_reviews
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
