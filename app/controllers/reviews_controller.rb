class ReviewsController < ApplicationController
    before_action :authorized, only: [:update,:create,:destroy]
    #before create and update actions one has to be authorized 

    def index 
        reviews=Review.all.sort 
        render json: reviews
    end

    def show 
        review=Review.find_by(id:params[:id])
        # render json: review
        # ({product_id:review.product.id})
        render json: ({product_id:review.product.id}).as_json.merge({review_id: review.id, rating: review.rating})
    end


    def ratingsummary
        user=User.find_by(id:params[:id]) 
        allrating=Review.where(user_id:user.id)
        render json: {rating: allrating.map{|review|ReviewSerializer.new(review).as_json.merge({name:review.product.name})}}
    end

    def allratingaverage 
        allratingaverage =Product.all.map{|product| {rating:Review.where(product_id:product.id).average(:rating).to_i,product_id:product.id,name:product.name}}
        render json: allratingaverage
    end

    def create

        
        # byebug #it knows the user_id from auth and token
        # review=Review.create(review_params)
        review=Review.create(rating:params[:rating], user:@user, product_id:params[:product_id])
        # review_product=@user.reviews.find_by(product)
        # review_count=@user.reviews.find_all{|product|product.product_id==params[:product_id]}.count
        # byebug
        # if review_count<1 
        if review.valid?
            partypass = encode_token({user_id: @user.id})
            render json: {user: UserSerializer.new(@user),token:partypass}
                # byebug
        else

            partypass = encode_token({user_id: @user.id})
            render json: {user: UserSerializer.new(@user),token:partypass}
            # render json: {error: "this product is already rated"}
        end
        # byebug
        # render json:  {review: ReviewSerializer.new(review)}
        # ProductSerializer.new(review.product).
        # render json:({product_id:review.product.id}).as_json.merge({review_id: review.id, rating: review.rating})

    end

    def destroy
        # byebug
        review=Review.find_by(id:params[:id]) #it knows the user_id from auth and token
        review.delete
        if review.valid?
            partypass = encode_token({user_id: @user.id})
            render json: {user: UserSerializer.new(@user),token:partypass}
        end 
    end


    def update
        # byebug
        review=Review.find_by(id:params[:id]) # it knows the user_id from auth and token
        review.update(rating:params[:rating])
        if review.valid?
            partypass = encode_token({user_id: @user.id})
            render json: {user: UserSerializer.new(@user),token:partypass}
        end 
    end


    def review_params
        params.permit(:rating, :user_id, :product_id)
    end


end
