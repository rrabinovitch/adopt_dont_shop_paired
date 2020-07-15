class ShelterReview < ApplicationRecord
  validates_presence_of :title, :rating, :content
  belongs_to :shelter

  def self.average(reviews)
    if reviews.length >= 1
      reviews.sum {|review| review.rating} / reviews.length
    else
      reviews.sum {|review| review.rating}
    end
  end
end
