class ReviewsController < ApplicationController
    before_action :authorized, only: [:update,:create]
    #before create and update actions one has to be authorized 

    def index 
        reviews=Review.all 
        render json: reviews
    end

    def show 
        review=Review.find_by(id:params[:id])
        # render json: review
        render json: ProductSerializer.new(review.product).as_json.merge({review_id: review.id, rating: review.rating})
    end

    def create
        # byebug #it knows the user_id from auth and token
        review=Review.create(review_params)
        # render json:  {review: ReviewSerializer.new(review)}
        render json: ProductSerializer.new(review.product).as_json.merge({review_id: review.id, rating: review.rating})

    end

    def update
        review=Review.find_by(id:params[:id]) # it knows the user_id from auth and token
        review.update(review_params)
        # render json: {review: ReviewSerializer.new(review)}
        render json: ProductSerializer.new(review.product).as_json.merge({review_id: review.id, rating: review.rating})
    end


    def review_params
        params.permit(:rating, :user_id, :product_id)
    end


end
