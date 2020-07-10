class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorite_pets
  # allows the method to be called from a view

  def favorite_pets
    @favorite_pets ||= Favorites.new(session[:favorites])
  end
end
