# frozen_string_literal: true

require "json"
require "ibm_watson/authenticators"
require "ibm_watson/natural_language_understanding_v1"

# If using IAM
authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
  apikey:ENV["apikey"]


natural_language_understanding = IBMWatson::NaturalLanguageUnderstandingV1.new(
  authenticator: authenticator,
  version: "2018-03-16"
)
natural_language_understanding.service_url = "https://api.us-east.natural-language-understanding.watson.cloud.ibm.com/instances/21007ec0-edd4-43f7-a8d6-3b61d569b4ac"

response = natural_language_understanding.analyze(
  text: "Bruce Banner is the Hulk and Bruce Wayne is BATMAN! " \
        "Superman fears not Banner, nice sweet delicious but Wayne",
  features: {
    "entities" => {},
    "keywords" => {},
    "emotion"=>{},
  }
).result
puts JSON.pretty_generate(response)