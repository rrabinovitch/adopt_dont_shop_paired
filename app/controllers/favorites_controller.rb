class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
    @favorites = Pet.find(favorite_pets.favorite_pets)
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:favorites] ||= Array.new

    if session[:favorites].include?(pet.id)
      flash[:alert] = "#{pet.name} has already been favorited."
    else
      session[:favorites] << pet_id_str
      flash[:notice] = "#{pet.name} has been added to your favorites list."
    end

    redirect_to "/pets/#{pet.id}"
  end
  
  def destroy
    pet = Pet.find(params[:pet_id])
    session[:favorites].delete(pet.id.to_s)
    flash[:notice] = "#{pet.name} has been removed to your favorites list."
    
    if URI(request.referer).path == "/favorites"
      redirect_to "/favorites"
    else URI(request.referer).path == "/pets/#{pet.id}"
      redirect_to "/pets/#{pet.id}"
    end
  end
  
  def destroy_all
    session[:favorites] = []
    flash[:notice] = "All pets have been removed from the favorites list"
    redirect_to '/favorites'
  end
  
end
