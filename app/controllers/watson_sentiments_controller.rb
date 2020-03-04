class WatsonSentimentsController < ApplicationController

    def show
        sentiment=WatsonSentiment.find_by(id:params[:id])
        render json: sentiment
    end

    def index
        sentiments=WatsonSentiment.all 
        render json: sentiments
    end
    # def create

    # end


    def analyze

        user=User.find_by(id:params[:id])
        response = NLU.analyze(
        text:user.comments.map{|comment|comment.user_comment}.join(" "),
        features: {
            "sentiment"=>{},
        }
        ).result

        # byebug

        sentiment=WatsonSentiment.create(score:response["sentiment"]["document"]["score"],label:response["sentiment"]["document"]["label"])
        # byebug
        render json: WatsonSentimentSerializer.new(sentiment).as_json.merge({user_id:user.id})
    
    end

end
