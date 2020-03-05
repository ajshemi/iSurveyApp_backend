class CommentsController < ApplicationController

    before_action :authorized, only: [:update,:destroy,:create]
    #before update action you need to be authorized

    def index
        comments=Comment.all.sort
        render json: comments
    end

    def show
        comment=Comment.find_by(id:params[:id])
        render json: comment
    end

    def create
        # byebug
        # comment=Comment.create(comment_params)
        comment=Comment.create(user_comment:params[:user_comment],user:@user)
        
        response = NLU.analyze(
        text:comment.user_comment,
        features: {
            "emotion"=>{},
            "sentiment"=>{}
        }
        ).result

        # byebug

        emotion=WatsonEmotion.create(user:@user,comment_id:comment.id,sadness:response["emotion"]["document"]["emotion"]["sadness"],joy:response["emotion"]["document"]["emotion"]["joy"],fear:response["emotion"]["document"]["emotion"]["fear"],disgust:response["emotion"]["document"]["emotion"]["disgust"],anger:response["emotion"]["document"]["emotion"]["anger"])
        sentiment=WatsonSentiment.create(user:@user,comment_id:comment.id,score:response["sentiment"]["document"]["score"],label:response["sentiment"]["document"]["label"])
        render json: {comment: CommentSerializer.new(comment), emotion:WatsonEmotionSerializer.new(emotion), sentiment:WatsonSentimentSerializer.new(sentiment)}
    end

    def update
        # byebug
        comment=Comment.find_by(id:params[:id])
        comment.update(comment_params)
        render json: comment
    end

    def destroy
        # byebug
        comment=Comment.find_by(id:params[:id])
        emotion=WatsonEmotion.find_by(comment_id:comment.id)
        sentiment=WatsonSentiment.find_by(comment_id:comment.id)
        # emotion=WatsonEmotion.create(comment_id:comment.id,sadness:response["emotion"]["document"]["emotion"]["sadness"],joy:response["emotion"]["document"]["emotion"]["joy"],fear:response["emotion"]["document"]["emotion"]["fear"],disgust:response["emotion"]["document"]["emotion"]["disgust"],anger:response["emotion"]["document"]["emotion"]["anger"])
        # sentiment=WatsonSentiment.create(comment_id:comment.id,score:response["sentiment"]["document"]["score"],label:response["sentiment"]["document"]["label"])
        comment.delete
        emotion.delete
        sentiment.delete
        render json:  {comment: CommentSerializer.new(comment), emotion:WatsonEmotionSerializer.new(emotion), sentiment:WatsonSentimentSerializer.new(sentiment)}
    end


    private
    def comment_params
        params.permit(:user_id, :user_comment)
    end

end
