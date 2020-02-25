class CommentsController < ApplicationController

    before_action :authorized, only: [:update,:destroy]
    #before update action you need to be authorized

    def index
        comments=Comment.all
        render json: comments
    end

    def show
        comment=Comment.find_by(id:params[:id])
        render json: comment
    end

    # def create
    #     comment=Comment.create(comment_params)
    #     render json: comment
    # end

    def update
        # byebug
        comment=Comment.find_by(id:params[:id])
        comment.update(comment_params)
        render json: comment
    end

    def destroy
        comment=Comment.find_by(id:params[:id])
        comment.delete
        render json: {}
    end


    private

    def comment_params
        params.permit(:user_id, :user_comment)
    end



end
