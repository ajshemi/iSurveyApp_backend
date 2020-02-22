class CommentsController < ApplicationController

    before_action :authorized, only: [:create,:update,:destroy]
    #before update action you need to be authorized

    # def index
    #     comments=Comment.all
    #     render json: comments
    # end

    def show
        comment=Comment.find_by(id:params[:id])
        render json: comment
    end

    def create
        comment=Comment.create(comment_params)
        render json: comment
    end

    def update
        comment=Comment.find_by(id:params[:id])
        comment.update(comment_params)
        render json: comment
    end

    def destroy
        comment=Comment.find_by(id:params[:id])
        comment.delete
        render json: {message: "IT HAS BEEN DELETED YAY", comment: comment}
    end


    private

    def comment_params
        params.permit(:user_id, :feedback)
    end



end
