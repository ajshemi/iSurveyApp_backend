# frozen_string_literal: true

require "json"
require "ibm_watson/authenticators"
require "ibm_watson/natural_language_understanding_v1"
# Access tokens are valid for approximately one hour and must be regenerated.?
# If using IAM
include IBMWatson
authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
  apikey:ENV['ibm_api_key']
)
NLU = IBMWatson::NaturalLanguageUnderstandingV1.new(
  authenticator: authenticator,
  version: "2019-07-12"
)
NLU.service_url = "https://api.us-east.natural-language-understanding.watson.cloud.ibm.com/instances/21007ec0-edd4-43f7-a8d6-3b61d569b4ac"

# response=User.all.map{|user| 
# natural_language_understandingNLUNLU.analyze(text:user.comments.map{|comment|comment.user_comment}.join(" "), features: {
#   "entities" => {},
#   "keywords" => {},
#   "emotion"=>{},
#   "sentiment"=>{}
# }).result

# }


# response = NLU.analyze(
#   text:User.first.comments.map{|comment|comment.user_comment}.join(" "),
#   # "Bruce Banner is the Hulk and Bruce Wayne is BATMAN! " \
#   # "Superman fears not Banner, nice sweet delicious but Wayne",
  
  
#   features: {
#     "entities" => {},
#     "keywords" => {},
#     "emotion"=>{},
#     "sentiment"=>{}
#   }
# ).result

# byebug
# puts JSON.pretty_generate(response)