require 'rails_helper'

RSpec.describe Favorites do
  describe '#total' do
    it "can calculate total number of favorites" do
      favorites = Favorites.new([1, 3])
      expect(favorites.total).to eq(2)
    end
  end
end
