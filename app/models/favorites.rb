class Favorites
  attr_reader :favorite_pets

  def initialize(initial_favorite_pets)
    @favorite_pets = initial_favorite_pets ||= Array.new
  end

  def total
    @favorite_pets.count
  end
end
