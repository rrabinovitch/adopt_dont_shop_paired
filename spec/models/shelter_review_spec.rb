require 'rails_helper'

RSpec.describe ShelterReviews, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :content }
  end

  # describe 'relationships' do
  #
  # end
end
