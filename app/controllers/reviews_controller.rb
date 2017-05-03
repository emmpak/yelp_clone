class ReviewsController < ApplicationController
  def new
    p params
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end
end
