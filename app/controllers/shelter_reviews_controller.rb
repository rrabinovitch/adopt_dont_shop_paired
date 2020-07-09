class ShelterReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_review = ShelterReview.new(shelter_review_params)
    if @shelter_review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Unsuccessful review submission: title, rating, and content needed in order to submit a review."
      render :new
    end
    # shelter_review.save
    # redirect_to "/shelters/#{params[:id]}"
  end

  def edit
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_review = ShelterReview.find(params[:review_id])
  end

  def update
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_review = ShelterReview.find(params[:review_id])
    @shelter_review.update(shelter_review_params)
    if @shelter_review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Unsuccessful review submission: title, rating, and content needed in order to submit a review."
      render :edit
    end
  end

  def destroy
    ShelterReview.destroy(params[:review_id])
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private
  def shelter_review_params
    params.permit(:title, :rating, :content, :picture, :shelter_id)
  end
end
