class FavoritesController < ApplicationController
  def index
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:favorites] ||= Hash.new
    session[:favorites][pet_id_str] = 1

    # session = a hash that's being stored temporarily (whether by closing browser or logging out)
    # unfavoriting:
      # as an array - search array for that pet id => delete it -- this approach is more resource heavy
      # as a hash - searching for the key of that ped id goes directly to that value rather than needing to search through a collection

    flash[:notice] = "#{pet.name} has been added to your favorites list."

    redirect_to "/pets/#{pet.id}"
  end
end
