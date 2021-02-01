class WatsonEmotionsController < ApplicationController
    before_action :authorized, only: [:update,:destroy,:create]

    def show
        emotion=WatsonEmotion.find_by(id:params[:id])
        render json: emotion
    end

    def index
        emotions=WatsonEmotion.all 
        render json: emotions
    end

    def analyze

        @user=User.find_by(id:params[:id])
        response = watson_nlu(   #NLU.analyze(
        text:@user.comments.map{|comment|comment.user_comment}.join(" "),
        
        features: {
            "emotion"=>{}
        }
        ).result

        # byebug

        emotion=WatsonEmotion.create(sadness:response["emotion"]["document"]["emotion"]["sadness"],joy:response["emotion"]["document"]["emotion"]["joy"],fear:response["emotion"]["document"]["emotion"]["fear"],disgust:response["emotion"]["document"]["emotion"]["disgust"],anger:response["emotion"]["document"]["emotion"]["anger"])
        # byebug
        render json: WatsonEmotionSerializer.new(emotion).as_json.merge({user_id:@user.id})
    end

    # t.integer "sadness"
    # t.integer "joy"
    # t.integer "fear"
    # t.integer "disgust"
    # t.integer "anger"
    
end
