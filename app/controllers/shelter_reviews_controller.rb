class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end
  
  def create

    shelter_review = ShelterReview.new({
              title: params[:title],
              rating: params[:rating],
              content: params[:content],
              picture: params[:picture],
              shelter_id: params[:id]
              })

    shelter_review.save
    redirect_to "/shelters/#{params[:id]}"
  end
end
