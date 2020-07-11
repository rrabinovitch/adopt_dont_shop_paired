class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
    @favorites = favorite_pets.favorite_array.map(&:to_i)
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
    session[:favorites].delete(params[:pet_id])
    redirect_to "/pets/#{params[:pet_id]}"
  end
end
