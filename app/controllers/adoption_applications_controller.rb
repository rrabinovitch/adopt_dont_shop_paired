class AdoptionApplicationsController < ApplicationController
  def new
    @favorite_pets = Pet.find(favorite_pets.favorite_pets)
    binding.pry
    # adoptable = they've been favorited and should be available to select in the application form
  end

  def create
    flash[:notice] = "Your adoption application has been submitted!"
    redirect_to '/favorites'
  end
end
