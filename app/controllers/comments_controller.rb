class CommentsController < ApplicationController

    before_action :authorized, only: [:update,:destroy,:create]
    #before update action you need to be authorized

    require "json"
    require "ibm_watson/authenticators"
    require "ibm_watson/natural_language_understanding_v1"
    # Access tokens are valid for approximately one hour and must be regenerated.?
    # If using IAM
    include IBMWatson
    authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
        apikey:ENV['NATURAL_LANGUAGE_UNDERSTANDING_APIKEY']
    )
    NLU = IBMWatson::NaturalLanguageUnderstandingV1.new(
        authenticator: authenticator,
        version: "2019-07-12"
    )
    NLU.service_url = ENV['NATURAL_LANGUAGE_UNDERSTANDING_URL']#"https://api.us-east.natural-language-understanding.watson.cloud.ibm.com/instances/21007ec0-edd4-43f7-a8d6-3b61d569b4ac"
    
    def watson_nlu(payload)
        NLU.analyze(payload)
    end

    def index
        comments=Comment.all
        render json: comments
    end

    def show
        comment=Comment.find_by(id:params[:id])
        render json: comment
    end

    def create
        # comment=Comment.create(comment_params)
        # if comment.valid?
        begin
            response = watson_nlu(   #NLU.analyze(
                text:params[:user_comment],
                # text:comment.user_comment,
                features: {
                    "emotion"=>{},
                    "sentiment"=>{}
                }
            ).result
        rescue  IBMWatson::ApiException => ex 
            # print "Method failed with status code #{ex.code}: #{ex.error}"
            # print "ex #{ex}"
        end
        #response = NLU.analyze( text:params[:user_comment],features: {"emotion"=>{}, "sentiment"=>{}})
    
        # byebug
        if response
            # puts @user
            comment=Comment.create(user_comment:params[:user_comment],user:@user)
            # comment=Comment.create(comment_params)
            emotion=WatsonEmotion.create(user:@user,comment_id:comment.id,sadness:response["emotion"]["document"]["emotion"]["sadness"],joy:response["emotion"]["document"]["emotion"]["joy"],fear:response["emotion"]["document"]["emotion"]["fear"],disgust:response["emotion"]["document"]["emotion"]["disgust"],anger:response["emotion"]["document"]["emotion"]["anger"])
            sentiment=WatsonSentiment.create(user:@user,comment_id:comment.id,score:response["sentiment"]["document"]["score"],label:response["sentiment"]["document"]["label"])
            render json: {comment: CommentSerializer.new(comment), emotion:WatsonEmotionSerializer.new(emotion), sentiment:WatsonSentimentSerializer.new(sentiment)}
            # byebug
        
        else
            # byebug
            # render json: {error: "invalid comment or Watson auth error"}
            render json: {error: "status code #{ex.code}: #{ex.error}"}
        end
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
