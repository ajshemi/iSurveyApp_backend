class ApplicationController < ActionController::API
  # before_action :authorized
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

  # def watson_nlu(payload)
  #   NLU.analyze(payload)
  # end

  def encode_token(payload)
    # should store secret in env variable
    JWT.encode(payload, 'cookiessecrets')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 'cookiessecrets', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?   #status: :unauthorized if !logged_in? 
  end

end